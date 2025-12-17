// Draw behind other objects
depth = 1000;

// Initialize progress system
scr_init_progress();

// Title
self.title = "BLOCK GAME";

// Total levels
self.total_levels = 109;

// Level select grid configuration
self.grid_cols = 5;
self.grid_rows = ceil(self.total_levels / self.grid_cols); // 22 rows for 109 levels
self.btn_size = 100;
self.btn_gap = 16;
self.grid_width = self.grid_cols * self.btn_size + (self.grid_cols - 1) * self.btn_gap;
self.grid_start_x = (room_width - self.grid_width) / 2 + self.btn_size / 2;
self.grid_start_y = 320;

// Scrolling
self.scroll_y = 0;
self.scroll_target = 0;
self.scroll_min = 0;
self.scroll_max = max(0, (self.grid_rows * (self.btn_size + self.btn_gap)) - 700);
self.mouse_down = false;
self.is_dragging = false;
self.drag_start_y = 0;
self.drag_start_scroll = 0;
self.scroll_velocity = 0;

// Visible area for clipping
self.visible_top = 280;
self.visible_bottom = room_height - 50;

// Create all level buttons
self.level_buttons = [];

for (var _level = 1; _level <= self.total_levels; _level++) {
    var _row = floor((_level - 1) / self.grid_cols);
    var _col = (_level - 1) mod self.grid_cols;
    var _bx = self.grid_start_x + _col * (self.btn_size + self.btn_gap);
    var _by = self.grid_start_y + _row * (self.btn_size + self.btn_gap);

    var _btn = instance_create_layer(_bx, _by, "instances", obj_button);
    _btn.width = self.btn_size;
    _btn.height = self.btn_size;
    _btn.level_num = _level;
    _btn.base_y = _by; // Store base Y for scrolling

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
