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

// Bounce off top wall
if (y <= _ball_h)
{
    vspeed = abs(vspeed);
    y = _ball_h;
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
