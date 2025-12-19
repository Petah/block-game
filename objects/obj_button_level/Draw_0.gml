draw_self();

if (self._level_data.stars > 0) {
    draw_sprite_ext(self._level_data.stars >= 1 ? spr_star_filled : spr_star_empty, 0, x - 22, y - 20, 0.18, 0.18, 15, c_white, 1);
    draw_sprite_ext(self._level_data.stars >= 3 ? spr_star_filled : spr_star_empty, 0, x + 22, y - 20, 0.18, 0.18, -15, c_white, 1);
    draw_sprite_ext(self._level_data.stars >= 2 ? spr_star_filled : spr_star_empty, 0, x, y - 28, 0.25, 0.25, 0, c_white, 1);
}

scr_draw_text(x, y + (self._level_data.stars > 0 ? 5 : 0), string(self._level_data.index), {
    font: fnt_xxl,
    color: c_white,
    halign: fa_center,
    valign: fa_middle,
    shadow: 2,
});

if (self._icon) {
    var _size = 15;
    var _xscale = _size / sprite_get_width(self._icon);
    var _yscale = _size / sprite_get_height(self._icon);
    draw_sprite_ext(self._icon, 0, x, y + 32, _xscale, _yscale, 0, c_white, 1);
    scr_draw_text(x - 13, y + 31, "+", {
        font: fnt_sm,
        color: c_white,
        halign: fa_center,
        valign: fa_middle,
        shadow: 1,
    });
}