scr_draw_overlay();

// Game over panel
draw_sprite_stretched(spr_ui_modal_red, 0, self._panel_x, self._panel_y, self._panel_w, self._panel_h);

// Text
var _cx = room_width / 2;
scr_draw_text(_cx, self._panel_y + 40, "GAME OVER", {
    font: fnt_xl, color: c_white, halign: fa_center, valign: fa_middle, shadow: 3
});
scr_draw_text(_cx, self._panel_y + 80, "Level: " + string(global._generated_level.level_data.index), {
    font: fnt_md, color: c_white, halign: fa_center
});
scr_draw_text(_cx, self._panel_y + 100, "Score: " + string(obj_game.score), {
    font: fnt_md, color: c_white, halign: fa_center
});

// Other options
scr_draw_text(_cx, self._panel_y + 355, "High Score: " + string(global._generated_level.level_data.high_score), {
    font: fnt_sm, color: make_color_rgb(251, 191, 36), halign: fa_center
});

// Draw buttons
scr_button_draw(self._buttons);
