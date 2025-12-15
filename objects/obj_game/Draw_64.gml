// === HEADER BAR (90px) ===
var _header_height = 90;

// Header gradient background
draw_set_alpha(1);
draw_rectangle_color(0, 0, room_width, _header_height,
    make_color_rgb(37, 37, 80), make_color_rgb(37, 37, 80),  // Top: #252550
    make_color_rgb(22, 22, 42), make_color_rgb(22, 22, 42),  // Bottom: #16162a
    false);

// Header bottom border
draw_set_color(make_color_rgb(63, 63, 122)); // #3f3f7a
draw_line_width(0, _header_height, room_width, _header_height, 2);

// Score section (left)
draw_set_halign(fa_left);
draw_set_color(make_color_rgb(156, 163, 175)); // #9ca3af
draw_text(30, 24, "SCORE");
draw_set_color(c_white);
draw_text(30, 48, string(self.score));

// Level badge (center)
var _badge_w = 100;
var _badge_h = 36;
var _badge_x = room_width / 2 - _badge_w / 2;
var _badge_y = (_header_height - _badge_h) / 2;

// Badge gradient background (rounded rectangle approximation)
draw_set_color(make_color_rgb(79, 70, 229)); // #4f46e5
draw_roundrect(_badge_x, _badge_y, _badge_x + _badge_w, _badge_y + _badge_h, false);
draw_set_color(make_color_rgb(55, 48, 163)); // #3730a3
draw_roundrect(_badge_x + 2, _badge_y + _badge_h/2, _badge_x + _badge_w - 2, _badge_y + _badge_h - 2, false);

// Level text
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(_badge_x + _badge_w / 2, _badge_y + 10, "LEVEL " + string(self.level));

// Ball count section (right)
draw_set_halign(fa_right);
draw_set_color(make_color_rgb(156, 163, 175)); // #9ca3af
draw_text(room_width - 30, 24, "BALLS");

// Small ball icon
var _ball_icon_x = room_width - 90;
var _ball_icon_y = 54;
draw_set_color(make_color_rgb(255, 107, 107)); // Ball red
draw_circle(_ball_icon_x, _ball_icon_y, 8, false);
draw_set_color(make_color_rgb(200, 60, 60)); // Darker outline
draw_circle(_ball_icon_x, _ball_icon_y, 8, true);

// Ball count text
draw_set_color(c_white);
draw_text(room_width - 30, 48, "x" + string(self.num_balls));


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
draw_set_alpha(0.8);
draw_set_halign(fa_center);
draw_text(room_width / 2, _danger_y + 18, "DANGER ZONE");

draw_set_alpha(1);


// === AIMING STATE ===
if (self.state == "aiming")
{
    // Draw instructions
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_set_alpha(0.7);
    draw_text(room_width / 2, room_height - 100, "Drag to aim, release to fire");
    draw_set_alpha(1);
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
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(156, 163, 175)); // #9ca3af
    draw_text(_pill_x + _pill_w / 2, _pill_y + 8, "Balls in play: " + string(_remaining));
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
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(239, 68, 68));
    draw_text(room_width / 2, _panel_y + 40, "GAME OVER");

    draw_set_color(c_white);
    draw_text(room_width / 2, _panel_y + 90, "Level reached: " + string(self.level));
    draw_text(room_width / 2, _panel_y + 120, "Score: " + string(self.score));

    draw_set_color(make_color_rgb(156, 163, 175));
    draw_text(room_width / 2, _panel_y + 160, "Press R to restart");
}


// === WIN OVERLAY ===
if (self.game_won)
{
    // Darken background
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);

    // Win panel
    var _panel_w = 300;
    var _panel_h = 200;
    var _panel_x = room_width / 2 - _panel_w / 2;
    var _panel_y = room_height / 2 - _panel_h / 2;

    draw_set_color(make_color_rgb(30, 30, 50));
    draw_roundrect(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, false);

    draw_set_color(make_color_rgb(34, 197, 94)); // Green border #22c55e
    draw_roundrect(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, true);

    // Text
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(34, 197, 94));
    draw_text(room_width / 2, _panel_y + 40, "YOU WIN!");

    draw_set_color(c_white);
    draw_text(room_width / 2, _panel_y + 90, "Final Score: " + string(self.score));

    draw_set_color(make_color_rgb(156, 163, 175));
    draw_text(room_width / 2, _panel_y + 160, "Press R to restart");
}


// Reset draw settings
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_alpha(1);
