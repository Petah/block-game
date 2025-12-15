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
                // Move back and determine bounce direction
                x -= _step_x;
                y -= _step_y;

                // Check horizontal collision
                if (place_meeting(x + _step_x, y, obj_block))
                {
                    _hsp = -_hsp;
                    _step_x = -_step_x;
                }

                // Check vertical collision
                if (place_meeting(x, y + _step_y, obj_block))
                {
                    _vsp = -_vsp;
                    _step_y = -_step_y;
                }

                // Move in new direction
                x += _step_x;
                y += _step_y;
            }

            // Handle split power-up
            if (self.will_split)
            {
                self.will_split = false;

                var _new_ball = instance_create_layer(x, y, "Instances", obj_ball);
                _new_ball.hspeed = -_hsp;
                _new_ball.vspeed = _vsp;
                _new_ball.ball_speed = self.ball_speed;

                // Track as bonus ball (resets each turn)
                obj_game.bonus_balls++;
            }

            // Reduce block health
            _block.health--;
            obj_game.score += 10;

            if (_block.health <= 0)
            {
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
