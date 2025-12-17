// Header gradient background
draw_set_alpha(1);
draw_rectangle_color(0, 0, room_width, self.header_height,
    make_color_rgb(37, 37, 80), make_color_rgb(37, 37, 80),  // Top: #252550
    make_color_rgb(22, 22, 42), make_color_rgb(22, 22, 42),  // Bottom: #16162a
    false);

// Header bottom border
draw_set_color(make_color_rgb(63, 63, 122)); // #3f3f7a
draw_line_width(0, self.header_height, room_width, self.header_height, 2);

// Score section (left)
scr_draw_text(30, 24, "SCORE", { font: fnt_sm, color: make_color_rgb(156, 163, 175) });
scr_draw_text(30, 48, string(self.score), { font: fnt_lg, color: c_white });

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
