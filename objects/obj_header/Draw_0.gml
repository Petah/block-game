scr_draw_reset();

draw_sprite_stretched(sprite_index, 0, 0, 0, room_width, global._header_height);

scr_button_draw(self._buttons);

// Score section (after back button)
scr_draw_text(90, 8, "SCORE", { font: fnt_xl, color: c_white, shadow: 1, halign: fa_left, valign: fa_top });
draw_sprite_stretched(spr_ui_box_grey_dark_thin, 0, 90, 40, 100, 40);
scr_draw_text(100, 42, string(obj_game.score), { font: fnt_xl, color: c_white });

// Lives display (hearts)
var _heart_x = 205 + sprite_get_width(spr_heart) / 2;
var _heart_y = 45 + sprite_get_height(spr_heart) / 2;
var _heart_spacing = 28;
scr_draw_text(200, 8, "LIVES", { font: fnt_xl, color: c_white, shadow: 1, halign: fa_left, valign: fa_top });
draw_sprite_stretched(spr_ui_box_grey_dark_thin, 0, 200, 40, 102, 40);
for (var i = 0; i < 3; i++)
{
    var _hx = _heart_x + i * _heart_spacing;
    var _width = 32;
    var _scale = _width / sprite_get_width(spr_heart);
    draw_sprite_ext(spr_heart, i < obj_game.lives ? 0 : 2, _hx, _heart_y, _scale, _scale, 0, c_white, 1);
}

// Level badge (center)
var _badge_w = 100;
var _badge_h = 36;
var _badge_x = room_width / 2 - _badge_w / 2;
var _badge_y = (global._header_height - _badge_h) / 2;

// Badge gradient background (rounded rectangle approximation)
draw_set_color(make_color_rgb(79, 70, 229)); // #4f46e5
draw_roundrect(_badge_x, _badge_y, _badge_x + _badge_w, _badge_y + _badge_h, false);
draw_set_color(make_color_rgb(55, 48, 163)); // #3730a3
draw_roundrect(_badge_x + 2, _badge_y + _badge_h/2, _badge_x + _badge_w - 2, _badge_y + _badge_h - 2, false);

// Level text
scr_draw_text(_badge_x + _badge_w / 2, _badge_y + 10, "LEVEL " + string(global._generated_level.level_data.index), {
    font: fnt_md, color: c_white, halign: fa_center
});

// Ball count section (right)
scr_draw_text(room_width - 30, 24, "BALLS", {
    font: fnt_sm, color: c_white, halign: fa_right
});

// Small ball icon
var _ball_icon_x = room_width - 90;
var _ball_icon_y = 54;
draw_sprite_ext(spr_ball, 0, _ball_icon_x, _ball_icon_y, 1, 1, 0, c_white, 1);

// Ball count text
scr_draw_text(room_width - 30, 48, "x" + string(obj_game.num_balls), {
    font: fnt_lg, color: c_white, halign: fa_right
});

