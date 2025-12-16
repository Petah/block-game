/// @function scr_spawn_blocks_row(_spawn_powerups)
/// @description Spawns a row of random blocks at the top of the grid (for endless mode)
/// @param {Bool} _spawn_powerups - Whether to spawn power-ups in empty cells

function scr_spawn_blocks_row(_spawn_powerups = true) {
    for (var _col = 0; _col < obj_game.grid_cols; _col++) {
        var _x = obj_game.grid_start_x + _col * obj_game.grid_cell_size;

        // Random chance to spawn a block (60-80% based on level)
        var _spawn_chance = min(60 + obj_game.level * 2, 85);
        if (random(100) < _spawn_chance) {
            // Health scales with level
            var _health = irandom_range(1, obj_game.level + 1);
            var _block = scr_spawn_block(_x, obj_game.grid_start_y, _health);

            // Special block types (start appearing after level 3)
            if (obj_game.level >= 3) {
                var _special_roll = random(100);
                if (_special_roll < 5) { // 5% explosive
                    _block.block_type = "explosive";
                    _block.sprite_index = spr_block_explosive;
                    _block.image_index = 0;
                } else if (_special_roll < 8) { // 3% steel
                    _block.block_type = "steel";
                    _block.health = 999;
                    _block.sprite_index = spr_block_steel;
                    _block.image_index = 0;
                } else if (_special_roll < 13) { // 5% rainbow
                    _block.block_type = "rainbow";
                    _block.sprite_index = spr_block_rainbow;
                    _block.image_index = 0;
                }
            }
        } else if (_spawn_powerups && random(100) < 20) { // 20% chance for power-up in empty cell
            var _powerup = instance_create_layer(_x, obj_game.grid_start_y, "instances", obj_power_up);
            _powerup.type = irandom(3);
            _powerup.image_index = _powerup.type;
        }
    }
}
