// Ball dimensions
var _ball_w = sprite_width / 2;
var _ball_h = sprite_height / 2;

// Store velocity and stop automatic movement
var _hsp = hspeed;
var _vsp = vspeed;
hspeed = 0;
vspeed = 0;

// Move in small steps to prevent tunneling through blocks
var _move_speed = point_distance(0, 0, _hsp, _vsp);
var _step_size = min(_move_speed, 8); // Max 8 pixels per step
var _steps = ceil(_move_speed / _step_size);

if (_steps > 0)
{
    var _step_x = _hsp / _steps;
    var _step_y = _vsp / _steps;

    for (var i = 0; i < _steps; i++)
    {
        // Move one step
        x += _step_x;
        y += _step_y;

        // Bounce off left and right walls
        if (x <= _ball_w)
        {
            _hsp = abs(_hsp);
            _step_x = abs(_step_x);
            x = _ball_w;
        }
        if (x >= room_width - _ball_w)
        {
            _hsp = -abs(_hsp);
            _step_x = -abs(_step_x);
            x = room_width - _ball_w;
        }

        // Bounce off top of grid area
        var _top_limit = obj_game.grid_start_y - obj_game.grid_cell_size / 2;
        if (y <= _top_limit + _ball_h)
        {
            _vsp = abs(_vsp);
            _step_y = abs(_step_y);
            y = _top_limit + _ball_h;
        }

        // Check for block collision at this step
        var _block = instance_place(x, y, obj_block);
        if (_block != noone)
        {
            // Only bounce if not a fireball
            if (!self.fireball)
            {
                // Move back to pre-collision position
                x -= _step_x;
                y -= _step_y;

                // Calculate block bounds (assuming centered origin)
                var _block_left = _block.x - _block.sprite_width / 2;
                var _block_right = _block.x + _block.sprite_width / 2;
                var _block_top = _block.y - _block.sprite_height / 2;
                var _block_bottom = _block.y + _block.sprite_height / 2;

                // Find closest point on block to ball center
                var _closest_x = clamp(x, _block_left, _block_right);
                var _closest_y = clamp(y, _block_top, _block_bottom);

                // Calculate normal from closest point to ball
                var _nx = x - _closest_x;
                var _ny = y - _closest_y;
                var _dist = point_distance(0, 0, _nx, _ny);

                if (_dist > 0)
                {
                    // Normalize
                    _nx /= _dist;
                    _ny /= _dist;

                    // Reflect velocity: v' = v - 2(v·n)n
                    var _dot = _hsp * _nx + _vsp * _ny;
                    _hsp = _hsp - 2 * _dot * _nx;
                    _vsp = _vsp - 2 * _dot * _ny;

                    // Update step values
                    var _speed = point_distance(0, 0, _hsp, _vsp);
                    _step_x = _hsp / _steps;
                    _step_y = _vsp / _steps;
                }
                else
                {
                    // Ball center inside block - fallback to axis-aligned bounce
                    if (place_meeting(x + _step_x, y, obj_block))
                    {
                        _hsp = -_hsp;
                        _step_x = -_step_x;
                    }
                    if (place_meeting(x, y + _step_y, obj_block))
                    {
                        _vsp = -_vsp;
                        _step_y = -_step_y;
                    }
                }

                // Move in new direction
                x += _step_x;
                y += _step_y;
            }

            // Handle split power-up
            if (self.will_split)
            {
                self.will_split = false;

                // Get absolute horizontal speed
                var _abs_hsp = abs(_hsp);

                // Create new ball
                var _new_ball = instance_create_layer(x, y, "Instances", obj_ball);
                _new_ball.ball_speed = self.ball_speed;
                _new_ball.vspeed = _vsp;

                // One ball goes left, one goes right
                _hsp = _abs_hsp;              // This ball goes right
                _new_ball.hspeed = -_abs_hsp; // New ball goes left

                // Update step values for this ball
                _step_x = _hsp / _steps;

                // Track as bonus ball (resets each turn)
                obj_game.bonus_balls++;
            }

            // Reset idle timer on block hit
            self.idle_timer = 0;

            // Reduce block health
            _block.health--;
            obj_game.score += 10;

            // Emit hit particles at block position
            part_particles_create(obj_particles.part_sys, _block.x, _block.y, obj_particles.part_block_hit, 5);

            if (_block.health <= 0)
            {
                // Increment combo and reset timer
                obj_game.combo++;
                obj_game.combo_timer = obj_game.combo_timeout;

                // Screen shake scales with combo (bigger combos = more shake)
                var _shake = min(2 + obj_game.combo * 0.5, 8);
                obj_game.shake_amount = max(obj_game.shake_amount, _shake);

                // Emit destroy particles before destroying
                part_particles_create(obj_particles.part_sys, _block.x, _block.y, obj_particles.part_block_destroy, 15);

                instance_destroy(_block);

                if (!instance_exists(obj_block))
                {
                    obj_game.game_won = true;
                }
            }

            // Only hit one block per frame (unless fireball)
            if (!self.fireball) break;
        }
    }
}

// Restore velocity for next frame
hspeed = _hsp;
vspeed = _vsp;

// Emit trail particles
if (_move_speed > 0)
{
    part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_ball_trail, 1);
}

// Increment idle timer and check for timeout
self.idle_timer++;
if (self.idle_timer >= self.idle_timeout)
{
    // Ball has been bouncing without hitting blocks for too long
    // First ball to return sets the new launch position
    if (obj_game.balls_returned == 0)
    {
        obj_game.launch_x = x;
    }

    obj_game.balls_returned++;
    instance_destroy();
    exit;
}

// Destroy ball when it goes off bottom
if (y > room_height + _ball_h)
{
    // First ball to return sets the new launch position
    if (obj_game.balls_returned == 0)
    {
        obj_game.launch_x = x;
    }

    obj_game.balls_returned++;
    instance_destroy();
    exit;
}
