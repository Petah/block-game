// Debug drawing - only when visible (press D to toggle)
if (!self.visible) exit;

// Draw grid (full room width)
draw_set_color(c_gray);
draw_set_alpha(0.3);

var _cell = obj_game.grid_cell_size;
var _grid_top = obj_game.grid_start_y - _cell / 2;

// Vertical lines
var _num_cols = ceil(room_width / _cell);
for (var _col = 0; _col <= _num_cols; _col++)
{
    var _x = _col * _cell;
    draw_line(_x, _grid_top, _x, obj_game.grid_bottom_y);
}

// Horizontal lines
var _num_rows = ceil((obj_game.grid_bottom_y - _grid_top) / _cell);
for (var _row = 0; _row <= _num_rows; _row++)
{
    var _y = _grid_top + _row * _cell;
    if (_y <= obj_game.grid_bottom_y)
    {
        draw_line(0, _y, room_width, _y);
    }
}

draw_set_alpha(1);

// Draw aiming line with bounces when dragging to aim
if (obj_game.is_dragging)
{
    var _start_x = obj_game.launch_x;
    var _start_y = obj_game.launch_y;
    var _angle = obj_game.aim_angle;

    var _max_bounces = 5;
    var _max_length = 1500; // Total line length
    var _length_remaining = _max_length;

    draw_set_color(c_lime);
    draw_set_alpha(0.7);

    for (var _bounce = 0; _bounce < _max_bounces && _length_remaining > 0; _bounce++)
    {
        var _dx = lengthdir_x(1, _angle);
        var _dy = lengthdir_y(1, _angle);

        // Find distance to each wall
        var _dist_left = (_dx < 0) ? (_start_x - 8) / abs(_dx) : 99999;
        var _dist_right = (_dx > 0) ? (room_width - 8 - _start_x) / _dx : 99999;
        var _dist_top = (_dy < 0) ? (_start_y - 8) / abs(_dy) : 99999;

        // Find closest wall
        var _dist = min(_dist_left, _dist_right, _dist_top, _length_remaining);

        // Calculate end point
        var _end_x = _start_x + _dx * _dist;
        var _end_y = _start_y + _dy * _dist;

        // Draw this segment
        draw_line_width(_start_x, _start_y, _end_x, _end_y, 2);

        // Draw bounce point
        if (_dist < _length_remaining)
        {
            draw_circle(_end_x, _end_y, 4, false);
        }

        _length_remaining -= _dist;

        // Determine which wall was hit and reflect
        if (_dist >= _length_remaining + _dist)
        {
            break; // Reached max length
        }
        else if (_dist == _dist_top)
        {
            // Hit top - reflect vertically
            _angle = -_angle;
        }
        else if (_dist == _dist_left || _dist == _dist_right)
        {
            // Hit side wall - reflect horizontally
            _angle = 180 - _angle;
        }

        // Start next segment from end point
        _start_x = _end_x;
        _start_y = _end_y;
    }

    draw_set_alpha(1);
}

// Draw debug indicators
draw_set_color(c_yellow);
draw_set_halign(fa_right);
draw_text(room_width - 10, 100, "DEBUG MODE [D]");
draw_text(room_width - 10, 120, "Speed: " + string(self.speed_multiplier) + "x [F]");
draw_text(room_width - 10, 140, "Test Room [T]");
draw_text(room_width - 10, 160, "Restart [R]");

// Debug phsyics
var _flag = phy_debug_render_aabb | phy_debug_render_collision_pairs | phy_debug_render_coms | phy_debug_render_core_shapes | phy_debug_render_joints | phy_debug_render_obb | phy_debug_render_shapes;
physics_world_draw_debug(_flag);

// Reset
draw_set_halign(fa_left);
draw_set_color(c_white);
