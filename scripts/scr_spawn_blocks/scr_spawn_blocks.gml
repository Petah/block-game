function scr_spawn_blocks() {
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
        }
        else if (random(100) < 20) // 20% chance for power-up in empty cell
        {
            var _powerup = instance_create_layer(_x, obj_game.grid_start_y, "Instances", obj_power_up);
            _powerup.type = irandom(3);
            _powerup.image_index = _powerup.type;
        }
    }
}