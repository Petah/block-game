function scr_move_blocks_down() {
    // Move all blocks down one row
    with (obj_block)
    {
        y += obj_game.grid_cell_size;

        // Check if any block reached the bottom
        if (y >= obj_game.grid_bottom_y)
        {
            obj_game.game_over = true;
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