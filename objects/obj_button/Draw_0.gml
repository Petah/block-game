// Calculate draw position (centered origin)
var _draw_x = x - self.width / 2;
var _draw_y = y - self.height / 2;

// Tint based on state
if (self.pressed)
{
    draw_set_color(make_color_rgb(180, 180, 220));
}
else if (self.hovered)
{
    draw_set_color(make_color_rgb(220, 220, 255));
}
else
{
    draw_set_color(c_white);
}

// Draw button using 9-slice stretched
draw_sprite_stretched_ext(spr_button, 0, _draw_x, _draw_y, self.width, self.height, draw_get_color(), 1);

// Draw text centered
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y, self.text);

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
