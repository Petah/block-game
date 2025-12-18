scr_draw_overlay();

// Level complete panel
var _panel_w = 400;
var _panel_h = 350;
var _panel_x = room_width / 2 - _panel_w / 2;
var _panel_y = room_height / 2 - _panel_h / 2;

var _pad = 16;

draw_sprite_stretched(spr_ui_modal_green, 0, _panel_x, _panel_y, _panel_w, _panel_h);

scr_draw_button(_panel_x + _pad, _panel_y + 200, _panel_w - 2 * _pad, 62, "NEXT LEVEL");
scr_draw_button(_panel_x + _pad, _panel_y + 270, _panel_w - 2 * _pad, 62, "BACK");

// Title
var _cx = room_width / 2;
scr_draw_text(_cx + 3, _panel_y + 80 + 3, "LEVEL COMPLETE!", {
    font: fnt_xl, color: c_black, halign: fa_center, valign: fa_middle
});
scr_draw_text(_cx, _panel_y + 80, "LEVEL COMPLETE!", {
    font: fnt_xl, color: c_white, halign: fa_center, valign: fa_middle
});

// Level number
scr_draw_text(_cx, _panel_y + 120, "Level " + string(obj_game.level), {
    font: fnt_lg, color: c_white, halign: fa_center, valign: fa_middle
});

// Draw stars using sprites
draw_sprite_ext(obj_game.stars_earned >= 1 ? spr_star_filled : spr_star_empty, 0, _panel_x + _panel_w / 2 - sprite_get_width(spr_star_empty) * 0.7, _panel_y, 0.8, 0.8, 15, c_white, 1); 
draw_sprite_ext(obj_game.stars_earned >= 3 ? spr_star_filled : spr_star_empty, 0, _panel_x + _panel_w / 2 + sprite_get_width(spr_star_empty) * 0.7, _panel_y, 0.8, 0.8, -15, c_white, 1);
draw_sprite_ext(obj_game.stars_earned >= 2 ? spr_star_filled : spr_star_empty, 0, _panel_x + _panel_w / 2, _panel_y - 15, 1,  1, 0, c_white, 1);

// Stats
scr_draw_text(_cx, _panel_y + 180, "Turns: " + string(obj_game.turns) + "  |  Score: " + string(obj_game.score), {
    font: fnt_sm, color: c_white, halign: fa_center, valign: fa_middle
});

// Instructions
// scr_draw_text(_cx, _panel_y + 280, "Click: Next Level", {
//     font: fnt_md, color: c_white, halign: fa_center, valign: fa_middle
// });
// scr_draw_text(_cx, _panel_y + 310, "Press M for Level Select", {
//     font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center, valign: fa_middle
// });
