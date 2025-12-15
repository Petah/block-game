// Draw background gradient
draw_rectangle_color(0, 0, room_width, room_height,
    make_color_rgb(15, 15, 35),  // Top: #0f0f23
    make_color_rgb(15, 15, 35),
    make_color_rgb(26, 26, 46),  // Bottom: #1a1a2e
    make_color_rgb(26, 26, 46),
    false);

// Subtle grid pattern
draw_set_color(c_white);
draw_set_alpha(0.03);

var _cell = self.grid_cell_size;
var _grid_top = self.grid_start_y;

// Horizontal lines
for (var _y = _grid_top; _y <= self.grid_bottom_y; _y += _cell)
{
    draw_line(0, _y, room_width, _y);
}

// Vertical lines
for (var _x = 0; _x <= room_width; _x += _cell)
{
    draw_line(_x, _grid_top, _x, self.grid_bottom_y);
}

draw_set_alpha(1);
