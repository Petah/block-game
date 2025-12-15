// Padding for screen shake (max shake is 8px)
var _pad = 16;

// Draw background gradient (larger to cover shake)
draw_rectangle_color(-_pad, -_pad, room_width + _pad, room_height + _pad,
    make_color_rgb(15, 15, 35),  // Top: #0f0f23
    make_color_rgb(15, 15, 35),
    make_color_rgb(26, 26, 46),  // Bottom: #1a1a2e
    make_color_rgb(26, 26, 46),
    false);
