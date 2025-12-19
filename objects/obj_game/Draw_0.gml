// Header gradient background
draw_set_alpha(1);
draw_rectangle_color(0, 0, room_width, global._header_height,
    make_color_rgb(37, 37, 80), make_color_rgb(37, 37, 80),  // Top: #252550
    make_color_rgb(22, 22, 42), make_color_rgb(22, 22, 42),  // Bottom: #16162a
    false);

// Header bottom border
draw_set_color(make_color_rgb(63, 63, 122)); // #3f3f7a
draw_line_width(0, global._header_height, room_width, global._header_height, 2);

// Score section (after back button)
scr_draw_text(100, 24, "SCORE", { font: fnt_sm, color: make_color_rgb(156, 163, 175) });
scr_draw_text(100, 48, string(self.score), { font: fnt_lg, color: c_white });

// Lives display (hearts)
var _heart_x = 200;
var _heart_y = 55;
var _heart_spacing = 28;
scr_draw_text(_heart_x, 24, "LIVES", { font: fnt_sm, color: make_color_rgb(156, 163, 175) });
for (var i = 0; i < 3; i++)
{
    var _filled = (i < self.lives);
    var _hx = _heart_x + i * _heart_spacing;
    var _alpha = _filled ? 1 : 0.3;
    var _color = _filled ? c_white : c_gray;
    var _width = 32;
    var _scale = _width / sprite_get_width(spr_heart);
    draw_sprite_ext(spr_heart, 0, _hx, _heart_y, _scale, _scale, 0, _color, _alpha);
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
    font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_right
});

// Small ball icon
var _ball_icon_x = room_width - 90;
var _ball_icon_y = 54;
draw_sprite_ext(spr_ball, 0, _ball_icon_x, _ball_icon_y, 1, 1, 0, c_white, 1);

// Ball count text
scr_draw_text(room_width - 30, 48, "x" + string(self.num_balls), {
    font: fnt_lg, color: c_white, halign: fa_right
});


// === PLAYING STATE - INSTRUCTIONS ===
var _text_y = obj_danger_zone.y - 50;
if (self.state == "playing" && !self.is_dragging && self.balls_available > 0)
{
    scr_draw_text(room_width / 2, _text_y, "Drag back to aim, release to fire", {
        font: fnt_sm, color: c_white, halign: fa_center, alpha: 0.7
    });
}

// === FIRING/WAITING STATE - BOTTOM UI ===
if (self.state == "firing" || self.state == "waiting")
{
    var _in_play = instance_number(obj_ball);
    scr_draw_text(room_width / 2, _text_y, "Balls in play: " + string(_in_play), {
        font: fnt_sm, color: c_white, halign: fa_center, alpha: 0.7
    });
}

scr_button_draw(self._buttons);
