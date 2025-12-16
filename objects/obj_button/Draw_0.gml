// Calculate draw position (centered origin)
var _draw_x = x - self.width / 2;
var _draw_y = y - self.height / 2;

// Tint based on state
var _tint = c_white;
if (self.locked)
{
    _tint = make_color_rgb(100, 100, 120);
}
else if (self.pressed)
{
    _tint = make_color_rgb(180, 180, 220);
}
else if (self.hovered)
{
    _tint = make_color_rgb(220, 220, 255);
}

// Draw button using 9-slice stretched
draw_sprite_stretched_ext(spr_button, 0, _draw_x, _draw_y, self.width, self.height, _tint, 1);

// Draw text centered
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (self.level_num > 0)
{
    if (self.locked)
    {
        // Draw lock icon
        var _lock_scale = 0.4;
        draw_sprite_ext(spr_lock, 0, x, y, _lock_scale, _lock_scale, 0, c_white, 0.7);
    }
    else
    {
        // Level button - draw number larger
        draw_set_color(c_white);
        draw_text_transformed(x, y - 12, self.text, 2, 2, 0);

        // Draw stars below the number using sprites
        var _star_y = y + 28;
        var _star_spacing = 26;
        var _star_start = x - _star_spacing;
        var _star_scale = 0.18;

        for (var i = 0; i < 3; i++)
        {
            var _star_x = _star_start + i * _star_spacing;
            var _star_spr = (i < self.stars) ? spr_star_filled : spr_star_empty;
            draw_sprite_ext(_star_spr, 0, _star_x, _star_y, _star_scale, _star_scale, 0, c_white, 1);
        }
    }
}
else
{
    // Regular button
    draw_set_color(c_white);
    draw_text(x, y, self.text);
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
