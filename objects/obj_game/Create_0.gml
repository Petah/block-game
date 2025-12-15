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
self.balls_to_return = 0;      // Locked count at start of turn
self.fire_delay = 0;           // Timer between ball shots
self.fire_interval = 5;        // Frames between each ball

// Aiming
self.is_aiming = false;
self.aim_angle = 90;           // Default aim straight up
self.launch_x = room_width / 2; // Where balls launch from
self.launch_y = room_height - 50; // Y position for launching

// Spawn shooter
instance_create_layer(self.launch_x, self.launch_y, "Instances", obj_shooter);

// Game state
self.state = "aiming";         // "aiming", "firing", "waiting"

// Bonus balls collected this turn (resets each turn)
self.bonus_balls = 0;

// Grid settings (full room width)
self.grid_cell_size = 32;
self.grid_cols = floor(room_width / self.grid_cell_size);
self.grid_start_x = self.grid_cell_size / 2; // First column center
self.grid_start_y = 80;
self.grid_bottom_y = room_height - 150; // Game over line

// Particle system
self.part_sys = part_system_create();
part_system_depth(self.part_sys, -100); // Draw above everything

// Block hit particles (small burst)
self.part_block_hit = part_type_create();
part_type_shape(self.part_block_hit, pt_shape_square);
part_type_size(self.part_block_hit, 0.2, 0.5, -0.02, 0);
part_type_color3(self.part_block_hit, c_white, c_yellow, c_orange);
part_type_alpha3(self.part_block_hit, 1, 0.8, 0);
part_type_speed(self.part_block_hit, 2, 5, -0.1, 0);
part_type_direction(self.part_block_hit, 0, 360, 0, 0);
part_type_life(self.part_block_hit, 15, 25);

// Block destroy particles (big explosion)
self.part_block_destroy = part_type_create();
part_type_shape(self.part_block_destroy, pt_shape_square);
part_type_size(self.part_block_destroy, 0.3, 0.8, -0.02, 0);
part_type_color3(self.part_block_destroy, c_white, c_lime, c_green);
part_type_alpha3(self.part_block_destroy, 1, 0.7, 0);
part_type_speed(self.part_block_destroy, 3, 7, -0.15, 0);
part_type_direction(self.part_block_destroy, 0, 360, 0, 0);
part_type_life(self.part_block_destroy, 20, 40);
part_type_gravity(self.part_block_destroy, 0.1, 270);

// Power-up collect particles (sparkle)
self.part_powerup = part_type_create();
part_type_shape(self.part_powerup, pt_shape_star);
part_type_size(self.part_powerup, 0.3, 0.6, -0.01, 0);
part_type_color3(self.part_powerup, c_white, c_aqua, c_blue);
part_type_alpha3(self.part_powerup, 1, 0.8, 0);
part_type_speed(self.part_powerup, 1, 3, -0.05, 0);
part_type_direction(self.part_powerup, 0, 360, 0, 0);
part_type_life(self.part_powerup, 30, 50);

// Ball trail particles
self.part_ball_trail = part_type_create();
part_type_shape(self.part_ball_trail, pt_shape_circle);
part_type_size(self.part_ball_trail, 0.2, 0.4, -0.02, 0);
part_type_color3(self.part_ball_trail, c_red, c_orange, c_yellow);
part_type_alpha3(self.part_ball_trail, 0.5, 0.3, 0);
part_type_life(self.part_ball_trail, 10, 15);

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
