// Ball dimensions
var _ball_w = sprite_width / 2;
var _ball_h = sprite_height / 2;

// Handle wall bounces (physics doesn't have room boundaries by default)
// Left wall
if (x <= _ball_w)
{
    x = _ball_w;
    phy_speed_x = abs(phy_speed_x);
}
// Right wall
if (x >= room_width - _ball_w)
{
    x = room_width - _ball_w;
    phy_speed_x = -abs(phy_speed_x);
}
// Top wall (below header)
var _top_limit = obj_game.header_height;
if (y <= _top_limit + _ball_h)
{
    y = _top_limit + _ball_h;
    phy_speed_y = abs(phy_speed_y);
}

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
