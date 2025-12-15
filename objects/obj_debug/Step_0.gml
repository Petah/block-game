// Press D to toggle debug UI visibility
if (keyboard_check_pressed(ord("D")))
{
    self.visible = !self.visible;
}

// Press F to cycle speed: 1x -> 2x -> 4x -> 1x
if (keyboard_check_pressed(ord("F")))
{
    if (self.speed_multiplier == 1)
        self.speed_multiplier = 2;
    else if (self.speed_multiplier == 2)
        self.speed_multiplier = 4;
    else
        self.speed_multiplier = 1;

    // Apply to all existing balls
    with (obj_ball)
    {
        var _current_speed = point_distance(0, 0, hspeed, vspeed);
        var _dir = point_direction(0, 0, hspeed, vspeed);
        var _new_speed = other.speed_multiplier * 8; // Base speed is 8

        hspeed = lengthdir_x(_new_speed, _dir);
        vspeed = lengthdir_y(_new_speed, _dir);
        ball_speed = _new_speed;
    }
}

// Press T to toggle between test room and game room
if (keyboard_check_pressed(ord("T")))
{
    if (room == rm_test)
        room_goto(rm_game);
    else
        room_goto(rm_test);
}

// Press R to restart current room
if (keyboard_check_pressed(ord("R")))
{
    room_restart();
}
