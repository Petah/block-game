// Draw behind other objects
depth = 1000;

// Spawn debug overlay
instance_create_layer(0, 0, "Instances", obj_debug);

// Initialize progress and get selected level
scr_init_progress();

// Game variables
self.score = 0;
self.level = global.selected_level;
self.game_over = false;
self.game_won = false;
self.level_complete = false;
self.stars_earned = 0;
self.turns = 0;

// Get level data
var _level_data = scr_get_level_data(self.level);

// Ball shooting system
self.num_balls = _level_data.balls; // From level data
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

// UI
self.header_height = 90;

// Grid settings - cols based on level layout or default for random
if (_level_data.layout != undefined) {
    self.grid_cols = array_length(_level_data.layout[0]);
} else {
    self.grid_cols = 32;
}
self.grid_cell_size = room_width / self.grid_cols;
self.grid_start_x = self.grid_cell_size / 2; // First column center
self.grid_start_y = self.header_height + self.grid_cell_size / 2; // Below header bar
self.grid_bottom_y = room_height - 150; // Game over line

// Spawn particle system manager
instance_create_layer(0, 0, "Instances", obj_particles);

// Spawn screen shake manager
instance_create_layer(0, 0, "Instances", obj_screen_shake);

// Combo system
self.combo = 0;
self.combo_timer = 0;
self.combo_timeout = 30; // Frames before combo resets

// Spawn blocks from level data or random generation
if (_level_data.layout != undefined) {
    scr_spawn_level_blocks(_level_data.layout);
} else {
    // Random generation for levels beyond 9
    scr_spawn_blocks(false);
    scr_move_blocks_down();
    scr_spawn_blocks(false);
    scr_move_blocks_down();
    scr_spawn_blocks(false);
    scr_move_blocks_down();
    scr_spawn_blocks();
    scr_move_blocks_down();
}