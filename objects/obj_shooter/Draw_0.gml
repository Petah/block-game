// Draw slingshot visualization when dragging
if (obj_game.is_dragging && obj_game.pull_strength > 0.1)
{
    var _pull = obj_game.pull_strength;

    // Draw pull-back line (from shooter to mouse)
    draw_set_color(make_color_rgb(239, 68, 68)); // Red #ef4444
    draw_set_alpha(0.6);
    draw_line_width(x, y, mouse_x, mouse_y, 3);

    // Draw trajectory preview dots
    draw_set_color(make_color_rgb(34, 197, 94)); // Green #22c55e

    var _line_length = 300 * _pull;
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
        var _alpha = (0.8 - (i / _num_dots) * 0.5) * _pull;
        draw_set_alpha(_alpha);

        var _dot_size = 4 * _pull;
        draw_circle(_dot_x, _dot_y, _dot_size, false);
    }

    // Draw ball preview at launch point
    draw_set_alpha(_pull);
    draw_sprite_ext(spr_ball, 0, x, y, 1, 1, 0, c_white, _pull * 0.8);

    draw_set_alpha(1);
    draw_set_color(c_white);
}

// Draw the sprite
draw_self();
