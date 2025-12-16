// Darken background
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);

// Level complete panel
var _panel_w = 400;
var _panel_h = 350;
var _panel_x = room_width / 2 - _panel_w / 2;
var _panel_y = room_height / 2 - _panel_h / 2;

draw_set_color(make_color_rgb(30, 30, 50));
draw_roundrect(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, false);

draw_set_color(make_color_rgb(34, 197, 94)); // Green border #22c55e
draw_roundrect(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, true);

// Title
var _cx = room_width / 2;
scr_draw_text(_cx, _panel_y + 50, "LEVEL COMPLETE!", {
    font: fnt_xl, color: make_color_rgb(34, 197, 94), halign: fa_center, valign: fa_middle
});

// Level number
scr_draw_text(_cx, _panel_y + 100, "Level " + string(obj_game.level), {
    font: fnt_lg, color: c_white, halign: fa_center, valign: fa_middle
});

// Draw stars using sprites
var _star_y = _panel_y + 160;
var _star_spacing = 70;
var _star_start = _cx - _star_spacing;

for (var i = 0; i < 3; i++)
{
    var _star_x = _star_start + i * _star_spacing;
    var _star_spr = (i < obj_game.stars_earned) ? spr_star_filled : spr_star_empty;
    draw_sprite_ext(_star_spr, 0, _star_x, _star_y, 0.5, 0.5, 0, c_white, 1);
}

// Stats
scr_draw_text(_cx, _panel_y + 220, "Turns: " + string(obj_game.turns) + "  |  Score: " + string(obj_game.score), {
    font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center, valign: fa_middle
});

// Instructions
scr_draw_text(_cx, _panel_y + 280, "Click: Next Level", {
    font: fnt_md, color: c_white, halign: fa_center, valign: fa_middle
});
scr_draw_text(_cx, _panel_y + 310, "Press M for Level Select", {
    font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center, valign: fa_middle
});

// Reset draw settings
draw_set_color(c_white);
draw_set_alpha(1);
