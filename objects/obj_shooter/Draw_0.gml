// Draw the sprite
draw_self();

// Draw aiming indicator when in aiming state
if (obj_game.state == "aiming")
{
    draw_set_color(make_color_rgb(34, 197, 94)); // Green #22c55e

    var _line_length = 400;
    var _dot_spacing = 20;
    var _num_dots = _line_length / _dot_spacing;

    for (var i = 1; i <= _num_dots; i++)
    {
        var _dist = i * _dot_spacing;
        var _dot_x = x + lengthdir_x(_dist, obj_game.aim_angle);
        var _dot_y = y + lengthdir_y(_dist, obj_game.aim_angle);

        // Stop if dot goes off screen or above grid
        if (_dot_y < obj_game.grid_start_y - 20) break;
        if (_dot_x < 0 || _dot_x > room_width) break;

        // Fade out dots further away
        var _alpha = 0.8 - (i / _num_dots) * 0.5;
        draw_set_alpha(_alpha);

        draw_circle(_dot_x, _dot_y, 4, false);
    }

    draw_set_alpha(1);
    draw_set_color(c_white);
}
