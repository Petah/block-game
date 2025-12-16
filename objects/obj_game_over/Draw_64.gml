// Darken background
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);

// Game over panel
var _panel_w = 300;
var _panel_h = 240;
var _panel_x = room_width / 2 - _panel_w / 2;
var _panel_y = room_height / 2 - _panel_h / 2;

draw_set_color(make_color_rgb(30, 30, 50));
draw_roundrect(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, false);

draw_set_color(make_color_rgb(239, 68, 68)); // Red border
draw_roundrect(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, true);

// Text
var _cx = room_width / 2;
scr_draw_text(_cx, _panel_y + 40, "GAME OVER", {
    font: fnt_xl, color: make_color_rgb(239, 68, 68), halign: fa_center
});
scr_draw_text(_cx, _panel_y + 90, "Level reached: " + string(obj_game.level), {
    font: fnt_md, color: c_white, halign: fa_center
});
scr_draw_text(_cx, _panel_y + 120, "Score: " + string(obj_game.score), {
    font: fnt_md, color: c_white, halign: fa_center
});
scr_draw_text(_cx, _panel_y + 150, "High Score: " + string(scr_get_high_score()), {
    font: fnt_md, color: make_color_rgb(251, 191, 36), halign: fa_center
});
scr_draw_text(_cx, _panel_y + 185, "Press R to restart", {
    font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center
});
scr_draw_text(_cx, _panel_y + 210, "Press M for Level Select", {
    font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center
});

// Reset draw settings
draw_set_color(c_white);
draw_set_alpha(1);
