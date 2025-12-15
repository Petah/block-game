// Get keyboard input
var _move = keyboard_check(vk_right) - keyboard_check(vk_left);

// Move paddle
x += _move * move_speed;

// Keep paddle within room bounds
x = clamp(x, sprite_width / 2, room_width - sprite_width / 2);
