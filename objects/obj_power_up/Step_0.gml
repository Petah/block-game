// Check collision with balls
var _ball = instance_place(x, y, obj_ball);
if (_ball != noone)
{
    // Apply power-up effect
    switch (self.type)
    {
        case 0: // Extra ball
            if (instance_exists(obj_game))
            {
                obj_game.num_balls += 1;
            }
            break;

        case 1: // Fireball - ball passes through blocks
            _ball.fireball = true;
            break;

        case 2: // Split - mark ball to split on next hit
            _ball.will_split = true;
            break;

        case 3: // Big ball - increase size
            _ball.image_xscale = 2;
            _ball.image_yscale = 2;
            break;
    }

    // Add score for collecting
    if (instance_exists(obj_game))
    {
        obj_game.score += 50;
    }

    // Destroy power-up
    instance_destroy();
}
