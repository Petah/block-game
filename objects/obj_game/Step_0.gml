// Restart game on R key when game is over or won
if ((self.game_over || self.game_won) && keyboard_check_pressed(ord("R")))
{
    room_restart();
}

// Don't process if game ended
if (self.game_over || self.game_won) exit;

var _launch_y = room_height - 50;

// State machine for game flow
switch (self.state)
{
    case "aiming":
        // Update aim based on mouse position
        var _dx = mouse_x - self.launch_x;
        var _dy = mouse_y - _launch_y;

        // Calculate angle (only allow upward angles)
        if (_dy < -10) // Mouse must be above launch point
        {
            self.aim_angle = point_direction(self.launch_x, _launch_y, mouse_x, mouse_y);
            // Clamp angle to prevent shooting downward (between 20 and 160 degrees)
            self.aim_angle = clamp(self.aim_angle, 20, 160);
        }

        // Fire on mouse click
        if (mouse_check_button_pressed(mb_left))
        {
            self.state = "firing";
            self.balls_fired = 0;
            self.balls_returned = 0;
            self.fire_delay = 0;
            // Lock in the number of balls to wait for (won't change mid-turn)
            self.balls_to_return = self.num_balls + self.bonus_balls;
        }
        break;

    case "firing":
        // Fire balls with delay between each
        self.fire_delay--;

        if (self.fire_delay <= 0 && self.balls_fired < self.balls_to_return)
        {
            // Create a ball and set its direction
            var _ball = instance_create_layer(self.launch_x, _launch_y, "Instances", obj_ball);

            // Apply debug speed multiplier if exists
            var _speed = _ball.ball_speed;
            if (instance_exists(obj_debug))
            {
                _speed *= obj_debug.speed_multiplier;
                _ball.ball_speed = _speed;
            }

            _ball.hspeed = lengthdir_x(_speed, self.aim_angle);
            _ball.vspeed = lengthdir_y(_speed, self.aim_angle);

            self.balls_fired++;
            self.fire_delay = self.fire_interval;
        }

        // Switch to waiting once all balls fired
        if (self.balls_fired >= self.balls_to_return)
        {
            self.state = "waiting";
        }
        break;

    case "waiting":
        // Wait for all balls to return
        // balls_to_return is locked at start, bonus_balls only increases from splits (which create balls)
        if (self.balls_returned >= self.balls_to_return + self.bonus_balls)
        {
            // All balls returned - advance to next turn
            self.level++;

            // Move all blocks down one row
            with (obj_block)
            {
                y += other.grid_cell_size;

                // Check if any block reached the bottom
                if (y >= other.grid_bottom_y)
                {
                    other.game_over = true;
                }
            }

            // Move all power-ups down one row
            with (obj_power_up)
            {
                // Destroy if it was collected by any ball
                if (array_length(self.collected_by) > 0)
                {
                    instance_destroy();
                }
                else
                {
                    y += other.grid_cell_size;

                    // Destroy if reached bottom
                    if (y >= other.grid_bottom_y)
                    {
                        instance_destroy();
                    }
                }
            }

            // Spawn new row at top (if not game over)
            if (!self.game_over)
            {
                for (var _col = 0; _col < self.grid_cols; _col++)
                {
                    var _x = self.grid_start_x + _col * self.grid_cell_size;

                    // Random chance to spawn a block (60-80% based on level)
                    var _spawn_chance = min(60 + self.level * 2, 85);
                    if (random(100) < _spawn_chance)
                    {
                        var _block = instance_create_layer(_x, self.grid_start_y, "Instances", obj_block);
                        // Health scales with level
                        _block.health = irandom_range(1, self.level + 1);
                    }
                    else if (random(100) < 20) // 20% chance for power-up in empty cell
                    {
                        var _powerup = instance_create_layer(_x, self.grid_start_y, "Instances", obj_power_up);
                        _powerup.type = irandom(3);
                        _powerup.image_index = _powerup.type;
                    }
                }
            }

            // Increase ball count for next turn
            self.num_balls++;

            // Reset bonus balls for next turn
            self.bonus_balls = 0;

            // Ready for next turn
            self.state = "aiming";
        }
        break;
}
