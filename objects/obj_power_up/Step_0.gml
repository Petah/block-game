// Check collision with balls
var _ball = instance_place(x, y, obj_ball);
if (_ball != noone)
{
    // Check if this ball already collected this power-up
    var _already_collected = false;
    for (var i = 0; i < array_length(self.collected_by); i++)
    {
        if (self.collected_by[i] == _ball)
        {
            _already_collected = true;
            break;
        }
    }

    // Only apply if not already collected by this ball
    if (!_already_collected)
    {
        // Mark as collected by this ball
        array_push(self.collected_by, _ball);

        // Emit power-up particles
        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_powerup, 10);

        // Apply power-up effect to THIS ball only
        switch (self.type)
        {
            case 0: // Extra ball - adds permanent ball for next turn
                obj_game.num_balls += 1;
                obj_game.score += 50;
                instance_destroy();
                exit;

            case 1: // Fireball - ball passes through blocks
                _ball.fireball = true;
                break;

            case 2: // Split - ball splits on next hit
                _ball.will_split = true;
                break;

            case 3: // Big ball - increase size
                _ball.image_xscale = 2;
                _ball.image_yscale = 2;
                break;
        }

        // Add score for collecting
        obj_game.score += 50;
    }

    // Power-up stays - ball passes through
}
