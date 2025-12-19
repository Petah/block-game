// Spawn blocks from level layout data
function scr_spawn_level_blocks(_layout) {
    var _rows = array_length(_layout);
    var _cols = array_length(_layout[0]);

    // Center the layout horizontally
    var _total_width = _cols * obj_game.grid_cell_size;
    var _start_x = (room_width - _total_width) / 2 + obj_game.grid_cell_size / 2;

    for (var _row = 0; _row < _rows; _row++) {
        var _y = obj_game.grid_start_y + _row * obj_game.grid_cell_size;

        for (var _col = 0; _col < _cols; _col++) {
            var _cell = _layout[_row][_col];
            var _x = _start_x + _col * obj_game.grid_cell_size;

            // Skip empty cells
            if (_cell == 0) continue;

            // Create block using scr_spawn_block - handles all types
            scr_spawn_block(_x, _y, _cell);
        }
    }
}
