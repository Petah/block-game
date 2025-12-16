// Game over input handling
if (keyboard_check_pressed(ord("R")))
{
    room_restart();
}
if (keyboard_check_pressed(ord("M")))
{
    room_goto(rm_main_menu);
}
