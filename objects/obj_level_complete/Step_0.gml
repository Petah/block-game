// Click to go to next level
if (mouse_check_button_pressed(mb_left))
{
    global.selected_level = obj_game.level + 1;
    room_restart();
}
// M to go to level select
if (keyboard_check_pressed(ord("M")))
{
    room_goto(rm_main_menu);
}
