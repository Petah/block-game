// Don't process if game ended or level complete
if (self.level_complete || self.game_over) exit;

// Count balls currently in play
var _balls_in_flight = instance_number(obj_ball);

// === SLINGSHOT AIMING AND FIRING ===
if (self.state == "playing")
{
    // Start drag when clicking in the launch area (danger zone / bottom area)
    if (mouse_check_button_pressed(mb_left) && !self.is_dragging)
    {
        // Only start drag if we have balls and click is in lower portion of screen
        if (self.balls_available > 0 && mouse_y > self.grid_bottom_y)
        {
            self.is_dragging = true;
            self.drag_start_x = mouse_x;
            self.drag_start_y = mouse_y;
        }
    }

    // Update aim while dragging
    if (self.is_dragging)
    {
        // Calculate pull vector (from current mouse to drag start = direction ball will go)
        var _dx = self.drag_start_x - mouse_x;
        var _dy = self.drag_start_y - mouse_y;
        var _pull_dist = point_distance(0, 0, _dx, _dy);

        // Calculate aim angle (opposite of drag direction)
        if (_pull_dist > 10)
        {
            self.aim_angle = point_direction(0, 0, _dx, _dy);
            // Clamp to upward angles only (between 20 and 160 degrees)
            self.aim_angle = clamp(self.aim_angle, 20, 160);
        }

        // Calculate pull strength (0 to 1)
        self.pull_strength = clamp(_pull_dist / self.max_pull_distance, 0, 1);

        // Update launch position to drag start point
        self.launch_x = clamp(self.drag_start_x, 50, room_width - 50);
    }

    // Fire on release
    if (mouse_check_button_released(mb_left) && self.is_dragging)
    {
        self.is_dragging = false;

        // Only fire if pulled back enough
        if (self.pull_strength > 0.1)
        {
            // Create and fire a ball
            var _ball = instance_create_layer(self.launch_x, self.launch_y, "instances", obj_ball);

            // Apply debug speed multiplier if exists
            var _speed = _ball.ball_speed * self.pull_strength;
            if (instance_exists(obj_debug))
            {
                _speed *= obj_debug.speed_multiplier;
            }
            _ball.ball_speed = _speed;

            // Apply physics impulse in the aim direction
            var _impulse_x = lengthdir_x(_speed, self.aim_angle);
            var _impulse_y = lengthdir_y(_speed, self.aim_angle);
            with (_ball) {
                physics_apply_impulse(x, y, _impulse_x, _impulse_y);
            }

            // Use a ball
            self.balls_available--;
            self.turns++; // Count each shot for star rating
        }

        // Reset pull strength
        self.pull_strength = 0;
    }

    // Cancel drag on right click
    if (mouse_check_button_pressed(mb_right) && self.is_dragging)
    {
        self.is_dragging = false;
        self.pull_strength = 0;
    }

    // Check for turn end condition: no balls in flight and no balls available
    if (_balls_in_flight == 0 && self.balls_available == 0 && !self.is_dragging)
    {
        self.state = "turn_ending";
        self.turn_end_timer = self.turn_end_delay;
    }
}

// === TURN ENDING ===
if (self.state == "turn_ending")
{
    // If a ball returns during this phase, go back to playing
    if (self.balls_available > 0)
    {
        self.state = "playing";
    }
    else
    {
        self.turn_end_timer--;

        if (self.turn_end_timer <= 0)
        {
            // Check if level is complete (no non-steel blocks remaining)
            var _non_steel_count = 0;
            with (obj_block) {
                if (block_type != "steel") _non_steel_count++;
            }

            if (_non_steel_count == 0)
            {
                // Level complete!
                self.level_complete = true;

                // Clear any remaining steel blocks
                with (obj_block) { instance_destroy(); }

                // Calculate and save stars
                self.stars_earned = scr_complete_level(self.level, self.turns);

                // Show level complete overlay
                instance_create_layer(0, 0, "instances", obj_level_complete);
            }
            else
            {
                // Move blocks down
                scr_move_blocks_down();

                // Get current level data to check if designed or random
                var _level_data = scr_get_level_data(self.level);

                if (_level_data.layout == undefined)
                {
                    // Random level - spawn new rows and increase balls
                    self.level++;

                    if (!self.game_over)
                    {
                        scr_spawn_blocks_row();
                    }

                    self.num_balls++;
                }

                // Reset balls for next turn
                self.balls_available = self.num_balls;

                // Reset bonus balls for next turn
                self.bonus_balls = 0;

                // Reset combo at turn end
                self.combo = 0;

                // Back to playing
                self.state = "playing";
            }
        }
    }
}

// Update combo timer
if (self.combo_timer > 0)
{
    self.combo_timer--;
    if (self.combo_timer <= 0)
    {
        self.combo = 0;
    }
}
