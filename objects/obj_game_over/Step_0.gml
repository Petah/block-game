// Game over input handling
if (keyboard_check_pressed(ord("R")))
{
    room_restart();
}
if (keyboard_check_pressed(ord("M")))
{
    room_goto(rm_main_menu);
}

// Check for extra balls button click
if (mouse_check_button_pressed(mb_left))
{
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // Check if click is within extra balls button
    if (variable_instance_exists(id, "extra_btn_x") &&
        _mx >= self.extra_btn_x && _mx <= self.extra_btn_x + self.extra_btn_w &&
        _my >= self.extra_btn_y && _my <= self.extra_btn_y + self.extra_btn_h)
    {
        // Add to cumulative extra balls count
        if (!variable_global_exists("extra_balls_count"))
        {
            global.extra_balls_count = 0;
        }
        global.extra_balls_count += 5;

        // Set flag to add extra balls on restart (checked in obj_game Create)
        global.restart_with_extra_balls = true;

        // Restart the level
        room_restart();
    }
}
