// Draw score and level
draw_set_color(c_white);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_text(10, 10, "Score: " + string(self.score));
draw_text(10, 30, "Level: " + string(self.level));

// Draw ball count
draw_set_halign(fa_right);
draw_text(room_width - 10, 10, "Balls: " + string(self.num_balls));

var _launch_y = room_height - 50;

// Draw danger line
draw_set_color(c_red);
draw_set_alpha(0.5);
draw_line_width(0, self.grid_bottom_y, room_width, self.grid_bottom_y, 2);
draw_set_alpha(1);

// Draw launch point indicator
draw_set_color(c_yellow);
draw_circle(self.launch_x, _launch_y, 10, false);

// Draw aiming line when in aiming state
if (self.state == "aiming")
{
    draw_set_color(c_white);

    // Draw dotted aim line
    var _line_length = 150;
    var _dot_spacing = 15;
    var _num_dots = _line_length / _dot_spacing;

    for (var i = 1; i <= _num_dots; i++)
    {
        var _dist = i * _dot_spacing;
        var _dot_x = self.launch_x + lengthdir_x(_dist, self.aim_angle);
        var _dot_y = _launch_y + lengthdir_y(_dist, self.aim_angle);
        draw_circle(_dot_x, _dot_y, 3, false);
    }

    // Draw instructions
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text(room_width / 2, room_height - 120, "Click to fire!");
}

// Draw firing/waiting status
if (self.state == "firing" || self.state == "waiting")
{
    draw_set_halign(fa_center);
    draw_set_color(c_gray);
    var _remaining = self.num_balls - self.balls_returned;
    draw_text(room_width / 2, room_height - 120, "Balls in play: " + string(_remaining));
}

// Draw game over message
if (game_over)
{
    draw_set_halign(fa_center);
    draw_set_color(c_red);
    draw_text(room_width / 2, room_height / 2, "GAME OVER!");
    draw_set_color(c_white);
    draw_text(room_width / 2, room_height / 2 + 40, "Level reached: " + string(self.level));
    draw_text(room_width / 2, room_height / 2 + 70, "Press R to restart");
}

// Draw win message
if (game_won)
{
    draw_set_halign(fa_center);
    draw_set_color(c_lime);
    draw_text(room_width / 2, room_height / 2, "YOU WIN!");
    draw_set_color(c_white);
    draw_text(room_width / 2, room_height / 2 + 40, "Final Score: " + string(self.score));
    draw_text(room_width / 2, room_height / 2 + 70, "Press R to restart");
}

// Reset draw settings
draw_set_halign(fa_left);
draw_set_color(c_white);
