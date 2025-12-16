function scr_spawn_blocks(_spawn_powerups = true) {
    for (var _col = 0; _col < obj_game.grid_cols; _col++)
    {
        var _x = obj_game.grid_start_x + _col * obj_game.grid_cell_size;

        // Random chance to spawn a block (60-80% based on level)
        var _spawn_chance = min(60 + obj_game.level * 2, 85);
        if (random(100) < _spawn_chance)
        {
            var _block = instance_create_layer(_x, obj_game.grid_start_y, "Instances", obj_block);
            // Health scales with level
            _block.health = irandom_range(1, obj_game.level + 1);

            // Special block types (start appearing after level 3)
            if (obj_game.level >= 3)
            {
                var _special_roll = random(100);
                if (_special_roll < 5) // 5% explosive
                {
                    _block.block_type = "explosive";
                }
                else if (_special_roll < 8) // 3% steel
                {
                    _block.block_type = "steel";
                    _block.health = 999; // Indestructible
                }
                else if (_special_roll < 13) // 5% rainbow
                {
                    _block.block_type = "rainbow";
                }
            }
        }
        else if (_spawn_powerups && random(100) < 20) // 20% chance for power-up in empty cell
        {
            var _powerup = instance_create_layer(_x, obj_game.grid_start_y, "Instances", obj_power_up);
            _powerup.type = irandom(3);
            _powerup.image_index = _powerup.type;
        }
    }
}