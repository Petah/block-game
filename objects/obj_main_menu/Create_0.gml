// Draw behind other objects
depth = 1000;

// Initialize progress system
scr_init_progress();

// Title
self.title = "BLOCK GAME";

// Level select grid (3x3 for 9 levels)
var _grid_cols = 3;
var _grid_rows = 3;
var _btn_size = 100;
var _btn_gap = 20;
var _grid_width = _grid_cols * _btn_size + (_grid_cols - 1) * _btn_gap;
var _grid_height = _grid_rows * _btn_size + (_grid_rows - 1) * _btn_gap;
var _start_x = (room_width - _grid_width) / 2 + _btn_size / 2;
var _start_y = 350;

self.level_buttons = [];

for (var row = 0; row < _grid_rows; row++) {
    for (var col = 0; col < _grid_cols; col++) {
        var _level = row * _grid_cols + col + 1;
        var _bx = _start_x + col * (_btn_size + _btn_gap);
        var _by = _start_y + row * (_btn_size + _btn_gap);

        var _btn = instance_create_layer(_bx, _by, "Instances", obj_button);
        _btn.width = _btn_size;
        _btn.height = _btn_size;
        _btn.level_num = _level;

        // Check if unlocked
        if (scr_is_level_unlocked(_level)) {
            _btn.text = string(_level);
            _btn.locked = false;
            _btn.stars = scr_get_level_stars(_level);

            // Capture level number for callback
            var _lvl = _level;
            _btn.on_click = method({ lvl: _lvl }, function() {
                global.selected_level = lvl;
                room_goto(rm_game);
            });
        } else {
            _btn.text = "";
            _btn.locked = true;
            _btn.stars = 0;
            _btn.on_click = undefined;
        }

        array_push(self.level_buttons, _btn);
    }
}
