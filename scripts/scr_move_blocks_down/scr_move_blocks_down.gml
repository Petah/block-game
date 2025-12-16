function scr_move_blocks_down() {
    // Move all blocks down one row
    with (obj_block)
    {
        // Use phy_position_y for physics objects
        phy_position_y += obj_game.grid_cell_size;

        // Check if any block reached the bottom (steel blocks don't cause game over)
        if (phy_position_y >= obj_game.grid_bottom_y)
        {
            if (self.block_type == "steel")
            {
                // Steel blocks just get destroyed at the bottom
                instance_destroy();
            }
            else if (!obj_game.game_over)
            {
                obj_game.game_over = true;
                instance_create_layer(0, 0, "ui", obj_game_over);
            }
        }

        // Rainbow blocks change health each turn
        if (self.block_type == "rainbow")
        {
            // Randomly change health by -2 to +3
            self.health += irandom_range(-2, 3);
            // Keep health between 1 and level + 5
            self.health = clamp(self.health, 1, obj_game.level + 5);
        }
    }

    // Move all power-ups down one row
    with (obj_power_up)
    {
        // Destroy if it was collected by any ball
        if (array_length(self.collected_by) > 0)
        {
            instance_destroy();
        }
        else
        {
            y += obj_game.grid_cell_size;

            // Destroy if reached bottom
            if (y >= obj_game.grid_bottom_y)
            {
                instance_destroy();
            }
        }
    }
}