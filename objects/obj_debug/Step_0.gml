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

    // Apply to all existing balls (using physics velocity)
    with (obj_ball)
    {
        var _current_speed = point_distance(0, 0, phy_speed_x, phy_speed_y);
        var _dir = point_direction(0, 0, phy_speed_x, phy_speed_y);
        var _base_speed = 800; // Base physics speed
        var _new_speed = other.speed_multiplier * _base_speed;

        phy_speed_x = lengthdir_x(_new_speed, _dir);
        phy_speed_y = lengthdir_y(_new_speed, _dir);
        ball_speed = _new_speed;
    }
}

// Press T to toggle test level (-1)
if (keyboard_check_pressed(ord("T")))
{
    if (global.selected_level == -1)
        global.selected_level = 1;
    else
        global.selected_level = -1;
    room_restart();
}

// Press R to restart current room
if (keyboard_check_pressed(ord("R")))
{
    room_restart();
}

// Press W to trigger level complete (Win)
if (keyboard_check_pressed(ord("W")))
{
    if (!instance_exists(obj_level_complete) && !instance_exists(obj_game_over))
    {
        instance_create_layer(0, 0, "Instances", obj_level_complete);
    }
}

// Press L to trigger game over (Lose)
if (keyboard_check_pressed(ord("L")))
{
    if (!instance_exists(obj_level_complete) && !instance_exists(obj_game_over))
    {
        instance_create_layer(0, 0, "Instances", obj_game_over);
    }
}
