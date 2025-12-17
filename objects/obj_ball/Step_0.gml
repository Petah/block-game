// Get current physics velocity
var _move_speed = point_distance(0, 0, phy_speed_x, phy_speed_y);

// Emit trail particles
if (_move_speed > 0)
{
    var _trail_part = self.fireball ? obj_particles.part_fire_trail : obj_particles.part_ball_trail;
    var _trail_count = self.fireball ? 3 : 1;
    part_particles_create(obj_particles.part_sys, x, y, _trail_part, _trail_count);
}

// Destroy ball when it goes off bottom
if (y > room_height + sprite_height)
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

// Handle split power-up (bonus balls can't split)
if (self.will_split && !self.is_bonus)
{
    self.will_split = false;

    // Create new ball
    var _new_ball = instance_create_layer(x, y, "instances", obj_ball);
    _new_ball.ball_speed = self.ball_speed;
    _new_ball.is_bonus = true;

    // One ball goes opposite horizontal direction
    _new_ball.phy_speed_x = -phy_speed_x;
    _new_ball.phy_speed_y = phy_speed_y;

    // Track as bonus ball (resets each turn)
    obj_game.bonus_balls++;
}
