// Draw background gradient
draw_rectangle_color(0, 0, room_width, room_height,
    make_color_rgb(15, 15, 35),  // Top: #0f0f23
    make_color_rgb(15, 15, 35),
    make_color_rgb(26, 26, 46),  // Bottom: #1a1a2e
    make_color_rgb(26, 26, 46),
    false);

// Draw title
scr_draw_text(room_width / 2, 120, "BLOCK GAME", {
    font: fnt_xl,
    color: c_white,
    halign: fa_center,
    valign: fa_middle
});

// Draw subtitle
scr_draw_text(room_width / 2, 220, "SELECT LEVEL", {
    font: fnt_lg,
    color: make_color_rgb(150, 150, 180),
    halign: fa_center,
    valign: fa_middle
});
