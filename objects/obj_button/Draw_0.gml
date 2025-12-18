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

if (self.level_num > 0)
{
    if (self.locked)
    {
        // Draw lock icon
        draw_sprite_ext(spr_lock, 0, x, y, 0.4, 0.4, 0, c_white, 0.7);
    }
    else
    {
        // Level button - draw number larger
        scr_draw_text(x, y - 14, self.text, {
            font: fnt_xl,
            color: c_white,
            halign: fa_center,
            valign: fa_middle,
            shadow: 2
        });

        // Draw stars below the number using sprites
        draw_sprite_ext(self.stars >= 1 ? spr_star_filled : spr_star_empty, 0, x - 22, y + 32, 0.18, 0.18, 15, c_white, 1);
        draw_sprite_ext(self.stars >= 3 ? spr_star_filled : spr_star_empty, 0, x + 22, y + 32, 0.18, 0.18, -15, c_white, 1);
        draw_sprite_ext(self.stars >= 2 ? spr_star_filled : spr_star_empty, 0, x, y + 24, 0.25, 0.25, 0, c_white, 1);
    }
}
else
{
    // Regular button
    scr_draw_text(x, y, self.text, {
        font: fnt_md,
        color: c_white,
        halign: fa_center,
        valign: fa_middle
    });
}
