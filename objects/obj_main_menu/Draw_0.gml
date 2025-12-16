// Draw background gradient
draw_rectangle_color(0, 0, room_width, room_height,
    make_color_rgb(15, 15, 35),  // Top: #0f0f23
    make_color_rgb(15, 15, 35),
    make_color_rgb(26, 26, 46),  // Bottom: #1a1a2e
    make_color_rgb(26, 26, 46),
    false);

// Draw title
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text_transformed(room_width / 2, 120, "BLOCK GAME", 3, 3, 0);

// Draw subtitle
draw_set_color(make_color_rgb(150, 150, 180));
draw_text_transformed(room_width / 2, 220, "SELECT LEVEL", 1.5, 1.5, 0);

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
