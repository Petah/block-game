// Header gradient background
draw_set_alpha(1);
draw_rectangle_color(0, 0, room_width, self.header_height,
    make_color_rgb(37, 37, 80), make_color_rgb(37, 37, 80),  // Top: #252550
    make_color_rgb(22, 22, 42), make_color_rgb(22, 22, 42),  // Bottom: #16162a
    false);

// Header bottom border
draw_set_color(make_color_rgb(63, 63, 122)); // #3f3f7a
draw_line_width(0, self.header_height, room_width, self.header_height, 2);

// Back button (left side)
var _btn_cx = self.back_btn_x + self.back_btn_w / 2;
var _btn_cy = self.back_btn_y + self.back_btn_h / 2;

// Button background
draw_set_color(make_color_rgb(55, 48, 163)); // #3730a3
draw_set_alpha(0.8);
draw_roundrect(self.back_btn_x, self.back_btn_y,
               self.back_btn_x + self.back_btn_w, self.back_btn_y + self.back_btn_h, false);
draw_set_alpha(1);

// Draw back arrow (chevron pointing left)
draw_set_color(c_white);
var _arrow_size = 12;
draw_line_width(_btn_cx + _arrow_size/2, _btn_cy - _arrow_size, _btn_cx - _arrow_size/2, _btn_cy, 3);
draw_line_width(_btn_cx - _arrow_size/2, _btn_cy, _btn_cx + _arrow_size/2, _btn_cy + _arrow_size, 3);

// Score section (after back button)
scr_draw_text(100, 24, "SCORE", { font: fnt_sm, color: make_color_rgb(156, 163, 175) });
scr_draw_text(100, 48, string(self.score), { font: fnt_lg, color: c_white });

// Lives display (hearts)
var _heart_x = 200;
var _heart_y = 45;
var _heart_spacing = 28;
scr_draw_text(_heart_x, 24, "LIVES", { font: fnt_sm, color: make_color_rgb(156, 163, 175) });
for (var i = 0; i < 3; i++)
{
    var _filled = (i < self.lives);
    var _hx = _heart_x + i * _heart_spacing;

    // Draw heart shape
    draw_set_color(_filled ? make_color_rgb(239, 68, 68) : make_color_rgb(80, 80, 100)); // Red or gray
    draw_set_alpha(_filled ? 1 : 0.4);

    // Simple heart using circles and triangle
    var _hs = 8; // heart size
    draw_circle(_hx - _hs/2, _heart_y, _hs/2, false);
    draw_circle(_hx + _hs/2, _heart_y, _hs/2, false);
    draw_triangle(_hx - _hs, _heart_y + 2, _hx + _hs, _heart_y + 2, _hx, _heart_y + _hs + 4, false);

    draw_set_alpha(1);
}

// Level badge (center)
var _badge_w = 100;
var _badge_h = 36;
var _badge_x = room_width / 2 - _badge_w / 2;
var _badge_y = (self.header_height - _badge_h) / 2;

// Badge gradient background (rounded rectangle approximation)
draw_set_color(make_color_rgb(79, 70, 229)); // #4f46e5
draw_roundrect(_badge_x, _badge_y, _badge_x + _badge_w, _badge_y + _badge_h, false);
draw_set_color(make_color_rgb(55, 48, 163)); // #3730a3
draw_roundrect(_badge_x + 2, _badge_y + _badge_h/2, _badge_x + _badge_w - 2, _badge_y + _badge_h - 2, false);

// Level text
scr_draw_text(_badge_x + _badge_w / 2, _badge_y + 10, "LEVEL " + string(self.level), {
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
var _text_y = self.grid_bottom_y - 50;
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
