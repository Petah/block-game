// Spawn debug overlay
instance_create_layer(0, 0, "Instances", obj_debug);

// Game variables
self.score = 0;
self.level = 1;
self.game_over = false;
self.game_won = false;

// Ball shooting system
self.num_balls = 10;           // Number of balls to fire
self.balls_fired = 0;          // Balls fired this turn
self.balls_returned = 0;       // Balls that came back
self.fire_delay = 0;           // Timer between ball shots
self.fire_interval = 5;        // Frames between each ball

// Aiming
self.is_aiming = false;
self.aim_angle = 90;           // Default aim straight up
self.launch_x = room_width / 2; // Where balls launch from

// Game state
self.state = "aiming";         // "aiming", "firing", "waiting"

// Grid settings (full room width)
self.grid_cell_size = 32;
self.grid_cols = floor(room_width / self.grid_cell_size);
self.grid_start_x = self.grid_cell_size / 2; // First column center
self.grid_start_y = 80;
self.grid_bottom_y = room_height - 150; // Game over line

// Spawn initial rows of blocks
for (var _row = 0; _row < 4; _row++)
{
    var _y = self.grid_start_y + _row * self.grid_cell_size;

    for (var _col = 0; _col < self.grid_cols; _col++)
    {
        // Random chance to spawn a block (70%)
        if (random(100) < 70)
        {
            var _x = self.grid_start_x + _col * self.grid_cell_size;
            var _block = instance_create_layer(_x, _y, "Instances", obj_block);
            // Random health between 1 and level+2
            _block.health = irandom_range(1, self.level + 2);
        }
    }
}
