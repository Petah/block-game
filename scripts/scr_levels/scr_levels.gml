// Level data definitions
// Each level has: balls (starting count), layout (2D array)
// Layout values: 0 = empty, positive number = block health
// Special: "e" = explosive, "s" = steel, "r" = rainbow (with health 2)

function scr_get_level_data(_level) {
    var _data = {};

    switch (_level) {
        case -1:
            // Test level: showcases all block types and power-ups
            _data.balls = 10;
            _data.layout = [
                [0,  0,  0,  0,  0,  0,  0,  0,  0],
                [2,  4,  6,  8, 10, 12, 14, 16, 18],
                [0,  0,  0,  0,  0,  0,  0,  0,  0],
                [0, "e", 5,  0, "s", 0,  5, "e", 0],
                [0,  5,  5,  0,  0,  0,  5,  5,  0],
                [0,  0,  0,  0, "r", 0,  0,  0,  0],
                [0,  0,  0,  0,  0,  0,  0,  0,  0],
            ];
            _data.spawn_powerups = true; // Special flag for test level
            break;

        case 1:
            // Level 1: Simple 3x3, 1 ball - Introduction
            _data.balls = 3;
            _data.layout = [
                [1, 1, 1],
                [1, 1, 1],
                [1, 1, 1]
            ];
            break;

        case 2:
            // Level 2: 4x3, 1 ball - Slightly larger
            _data.balls = 3;
            _data.layout = [
                [1, 1, 1, 1],
                [1, 2, 2, 1],
                [1, 1, 1, 1]
            ];
            break;

        case 3:
            // Level 3: 5x4, 2 balls - Getting bigger
            _data.balls = 3;
            _data.layout = [
                [1, 1, 1, 1, 1],
                [1, 2, 2, 2, 1],
                [1, 2, 2, 2, 1],
                [1, 1, 1, 1, 1]
            ];
            break;

        case 4:
            // Level 4: 6x4, 2 balls - Diamond pattern
            _data.balls = 3;
            _data.layout = [
                [0, 0, 2, 2, 0, 0],
                [0, 2, 3, 3, 2, 0],
                [2, 3, 3, 3, 3, 2],
                [0, 2, 3, 3, 2, 0],
                [0, 0, 2, 2, 0, 0]
            ];
            break;

        case 5:
            // Level 5: 7x5, 3 balls - Introduce explosive
            _data.balls = 3;
            _data.layout = [
                [1, 1, 1, 1, 1, 1, 1],
                [1, 2, 2, "e", 2, 2, 1],
                [1, 2, 3, 3, 3, 2, 1],
                [1, 2, 2, "e", 2, 2, 1],
                [1, 1, 1, 1, 1, 1, 1]
            ];
            break;

        case 6:
            // Level 6: 8x5, 3 balls - More explosives
            _data.balls = 3;
            _data.layout = [
                [2, 2, 2, 2, 2, 2, 2, 2],
                [2, 3, 3, "e", "e", 3, 3, 2],
                [2, 3, 4, 4, 4, 4, 3, 2],
                [2, 3, 3, "e", "e", 3, 3, 2],
                [2, 2, 2, 2, 2, 2, 2, 2]
            ];
            break;

        case 7:
            // Level 7: 9x6, 4 balls - Introduce steel
            _data.balls = 4;
            _data.layout = [
                [1, 1, 2, 2, 2, 2, 2, 1, 1],
                [1, 2, 3, 3, "s", 3, 3, 2, 1],
                [2, 3, 3, 4, 4, 4, 3, 3, 2],
                [2, 3, 3, 4, 4, 4, 3, 3, 2],
                [1, 2, 3, 3, "s", 3, 3, 2, 1],
                [1, 1, 2, 2, 2, 2, 2, 1, 1]
            ];
            break;

        case 8:
            // Level 8: 10x6, 4 balls - Steel fortress with explosives
            _data.balls = 4;
            _data.layout = [
                ["s", 2, 2, 2, 2, 2, 2, 2, 2, "s"],
                [2, 3, 3, "e", 4, 4, "e", 3, 3, 2],
                [2, 3, 4, 4, 5, 5, 4, 4, 3, 2],
                [2, 3, 4, 4, 5, 5, 4, 4, 3, 2],
                [2, 3, 3, "e", 4, 4, "e", 3, 3, 2],
                ["s", 2, 2, 2, 2, 2, 2, 2, 2, "s"]
            ];
            break;

        case 9:
            // Level 9: 12x7, 5 balls - Rainbow chaos
            _data.balls = 5;
            _data.layout = [
                [2, 2, 2, "r", 3, 3, 3, 3, "r", 2, 2, 2],
                [2, 3, 3, 3, 4, "e", "e", 4, 3, 3, 3, 2],
                [2, 3, "s", 4, 4, 5, 5, 4, 4, "s", 3, 2],
                ["r", 3, 4, 4, 5, 6, 6, 5, 4, 4, 3, "r"],
                [2, 3, "s", 4, 4, 5, 5, 4, 4, "s", 3, 2],
                [2, 3, 3, 3, 4, "e", "e", 4, 3, 3, 3, 2],
                [2, 2, 2, "r", 3, 3, 3, 3, "r", 2, 2, 2]
            ];
            break;

        default:
            // After level 9, generate random levels with increasing difficulty
            _data.balls = min(5 + floor((_level - 9) / 2), 15);
            _data.layout = undefined; // Signal to use random generation
            break;
    }

    return _data;
}

// Spawn blocks from level layout data
function scr_spawn_level_blocks(_layout) {
    if (_layout == undefined) return false;

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

    return true;
}
