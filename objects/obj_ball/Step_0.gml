// Ball dimensions
var _ball_w = sprite_width / 2;
var _ball_h = sprite_height / 2;

// Bounce off left and right walls
if (x <= _ball_w)
{
    hspeed = abs(hspeed);
    x = _ball_w;
}
if (x >= room_width - _ball_w)
{
    hspeed = -abs(hspeed);
    x = room_width - _ball_w;
}

// Bounce off top of grid area (not top of room)
var _top_limit = 64; // grid_start_y - grid_cell_size/2
if (instance_exists(obj_game))
{
    _top_limit = obj_game.grid_start_y - obj_game.grid_cell_size / 2;
}
if (y <= _top_limit + _ball_h)
{
    vspeed = abs(vspeed);
    y = _top_limit + _ball_h;
}

// Destroy ball when it goes off bottom - notify game controller
if (y > room_height + _ball_h)
{
    if (instance_exists(obj_game))
    {
        obj_game.balls_returned++;
    }
    instance_destroy();
    exit;
}

// Collision with blocks - reduce health
var _block = instance_place(x, y, obj_block);
if (_block != noone)
{
    // Only bounce if not a fireball
    if (!self.fireball)
    {
        // Determine bounce direction based on collision side
        var _prev_x = x - hspeed;
        var _prev_y = y - vspeed;

        // Check if we were above/below or to the side
        if (!place_meeting(_prev_x, y, obj_block))
        {
            hspeed = -hspeed;
        }
        if (!place_meeting(x, _prev_y, obj_block))
        {
            vspeed = -vspeed;
        }
    }

    // Handle split power-up
    if (self.will_split)
    {
        self.will_split = false;

        // Create a second ball going in mirrored direction
        var _new_ball = instance_create_layer(x, y, "Instances", obj_ball);
        _new_ball.hspeed = -hspeed;
        _new_ball.vspeed = vspeed;
        _new_ball.ball_speed = self.ball_speed;

        // Inherit size if big
        _new_ball.image_xscale = image_xscale;
        _new_ball.image_yscale = image_yscale;

        // Notify game of extra ball
        if (instance_exists(obj_game))
        {
            obj_game.num_balls++;
        }
    }

    // Reduce block health
    _block.health--;

    // Add score
    if (instance_exists(obj_game))
    {
        obj_game.score += 10;
    }

    // Destroy block if health depleted
    if (_block.health <= 0)
    {
        instance_destroy(_block);

        // Check for win condition
        if (!instance_exists(obj_block))
        {
            if (instance_exists(obj_game))
            {
                obj_game.game_won = true;
            }
        }
    }
}
