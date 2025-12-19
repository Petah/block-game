scr_draw_overlay();

// Level complete panel
draw_sprite_stretched(spr_ui_modal_green, 0, self._panel_x, self._panel_y, self._panel_w, self._panel_h);

scr_button_draw(self._buttons);

// Title
var _cx = room_width / 2;
scr_draw_text(_cx, self._panel_y + 80, "LEVEL COMPLETE!", {
    font: fnt_xl, color: c_white, halign: fa_center, valign: fa_middle, shadow: 3
});

// Level number
scr_draw_text(_cx, self._panel_y + 120, "Level " + string(global._generated_level.level_data.index), {
    font: fnt_lg, color: c_white, halign: fa_center, valign: fa_middle
});

// Draw stars using sprites
var _stars_earned = scr_calculate_stars();
draw_sprite_ext(_stars_earned >= 1 ? spr_star_filled : spr_star_empty, 0, self._panel_x + self._panel_w / 2 - sprite_get_width(spr_star_empty) * 0.7, self._panel_y, 0.8, 0.8, 15, c_white, 1); 
draw_sprite_ext(_stars_earned >= 3 ? spr_star_filled : spr_star_empty, 0, self._panel_x + self._panel_w / 2 + sprite_get_width(spr_star_empty) * 0.7, self._panel_y, 0.8, 0.8, -15, c_white, 1);
draw_sprite_ext(_stars_earned >= 2 ? spr_star_filled : spr_star_empty, 0, self._panel_x + self._panel_w / 2, self._panel_y - 15, 1,  1, 0, c_white, 1);

// Stats
scr_draw_text(_cx, self._panel_y + 180, "Turns: " + string(obj_game._turns) + "  |  Score: " + string(obj_game.score), {
    font: fnt_sm, color: c_white, halign: fa_center, valign: fa_middle
});
