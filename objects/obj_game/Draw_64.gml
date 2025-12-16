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
draw_set_color(make_color_rgb(255, 107, 107)); // Ball red
draw_circle(_ball_icon_x, _ball_icon_y, 8, false);
draw_set_color(make_color_rgb(200, 60, 60)); // Darker outline
draw_circle(_ball_icon_x, _ball_icon_y, 8, true);

// Ball count text
scr_draw_text(room_width - 30, 48, "x" + string(self.num_balls), {
    font: fnt_lg, color: c_white, halign: fa_right
});


// === DANGER ZONE ===
var _danger_y = self.grid_bottom_y;

// Red danger line
draw_set_color(make_color_rgb(239, 68, 68)); // #ef4444
draw_set_alpha(0.8);
draw_line_width(0, _danger_y, room_width, _danger_y, 4);

// Faded danger area
draw_set_alpha(0.1);
draw_rectangle(0, _danger_y + 4, room_width, _danger_y + 44, false);

// Danger zone text
scr_draw_text(room_width / 2, _danger_y + 18, "DANGER ZONE", {
    font: fnt_sm, color: make_color_rgb(239, 68, 68), halign: fa_center, alpha: 0.8
});

draw_set_alpha(1);


// === AIMING STATE ===
if (self.state == "aiming")
{
    scr_draw_text(room_width / 2, room_height - 100, "Drag to aim, release to fire", {
        font: fnt_sm, color: c_white, halign: fa_center, alpha: 0.7
    });
}


// === FIRING/WAITING STATE - BOTTOM UI ===
if (self.state == "firing" || self.state == "waiting")
{
    var _remaining = self.balls_to_return - self.balls_returned;

    // Rounded pill background
    var _pill_w = 140;
    var _pill_h = 30;
    var _pill_x = 20;
    var _pill_y = room_height - 50;

    draw_set_color(make_color_rgb(55, 65, 81)); // #374151
    draw_set_alpha(0.8);
    draw_roundrect(_pill_x, _pill_y, _pill_x + _pill_w, _pill_y + _pill_h, false);
    draw_set_alpha(1);

    // Text
    scr_draw_text(_pill_x + _pill_w / 2, _pill_y + 8, "Balls in play: " + string(_remaining), {
        font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center
    });
}


// === GAME OVER OVERLAY ===
if (self.game_over)
{
    // Darken background
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);

    // Game over panel
    var _panel_w = 300;
    var _panel_h = 200;
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
    scr_draw_text(_cx, _panel_y + 90, "Level reached: " + string(self.level), {
        font: fnt_md, color: c_white, halign: fa_center
    });
    scr_draw_text(_cx, _panel_y + 120, "Score: " + string(self.score), {
        font: fnt_md, color: c_white, halign: fa_center
    });
    scr_draw_text(_cx, _panel_y + 150, "Press R to restart", {
        font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center
    });
    scr_draw_text(_cx, _panel_y + 175, "Press M for Level Select", {
        font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center
    });
}


// === LEVEL COMPLETE OVERLAY ===
if (self.level_complete)
{
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
    scr_draw_text(_cx, _panel_y + 100, "Level " + string(self.level), {
        font: fnt_lg, color: c_white, halign: fa_center, valign: fa_middle
    });

    // Draw stars using sprites
    var _star_y = _panel_y + 160;
    var _star_spacing = 70;
    var _star_start = _cx - _star_spacing;

    for (var i = 0; i < 3; i++)
    {
        var _star_x = _star_start + i * _star_spacing;
        var _star_spr = (i < self.stars_earned) ? spr_star_filled : spr_star_empty;
        draw_sprite_ext(_star_spr, 0, _star_x, _star_y, 0.5, 0.5, 0, c_white, 1);
    }

    // Stats
    scr_draw_text(_cx, _panel_y + 220, "Turns: " + string(self.turns) + "  |  Score: " + string(self.score), {
        font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center, valign: fa_middle
    });

    // Instructions
    scr_draw_text(_cx, _panel_y + 280, "Click: Next Level", {
        font: fnt_md, color: c_white, halign: fa_center, valign: fa_middle
    });
    scr_draw_text(_cx, _panel_y + 310, "Press M for Level Select", {
        font: fnt_sm, color: make_color_rgb(156, 163, 175), halign: fa_center, valign: fa_middle
    });
}


// Reset draw settings (for non-text drawing)
draw_set_color(c_white);
draw_set_alpha(1);
