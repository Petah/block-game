// Draw behind other objects
depth = 1000;

// Spawn debug overlay
instance_create_layer(0, 0, "ui", obj_debug);

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

// Ball shooting system (slingshot style with burst fire)
self.num_balls = _level_data.balls; // Total balls available
self.balls_available = self.num_balls; // Balls ready to fire

// Slingshot aiming
self.is_dragging = false;
self.drag_start_x = 0;
self.drag_start_y = 0;
self.aim_angle = 90;           // Current aim direction
self.pull_strength = 0;        // How far pulled back (0-1)
self.max_pull_distance = 150;  // Max drag distance for full power

// Burst firing
self.fire_delay = 0;           // Timer between ball shots
self.fire_interval = 5;        // Frames between each ball
self.balls_to_fire = 0;        // How many balls left to fire in burst
self.fire_speed = 0;           // Locked speed when firing starts

// Launch position (where balls fire from)
self.launch_x = room_width / 2;
self.launch_y = room_height - 80;

// Spawn shooter
instance_create_layer(self.launch_x, self.launch_y, "instances", obj_shooter);

// Game state: "playing", "firing", "waiting", "turn_ending"
self.state = "playing";
self.turn_end_timer = 0;       // Timer before turn ends after all balls return
self.turn_end_delay = 60;      // Frames to wait before ending turn (1 second)

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

// Calculate grid_bottom_y aligned to grid (leave room for shooter at bottom)
var _min_bottom_margin = 140; // Minimum space for shooter area
var _available_height = room_height - self.header_height - _min_bottom_margin;
var _num_rows = floor(_available_height / self.grid_cell_size);
self.grid_bottom_y = self.header_height + (_num_rows * self.grid_cell_size); // Aligned to grid

// Spawn danger zone
instance_create_layer(0, 0, "bg_instances", obj_danger_zone);
obj_danger_zone.x = room_width / 2;
obj_danger_zone.y = self.grid_bottom_y;

// Spawn physics walls (left, right, top)
var _wall_thickness = 32;

// Left wall
scr_create_wall(-_wall_thickness, 0, _wall_thickness, room_height);

// Right wall
scr_create_wall(room_width, 0, _wall_thickness, room_height);

// Top wall (below header)
scr_create_wall(0, self.header_height - _wall_thickness, room_width, _wall_thickness);

// Spawn particle system manager
instance_create_layer(0, 0, "bg_instances", obj_particles);

// Spawn screen shake manager
instance_create_layer(0, 0, "bg_instances", obj_screen_shake);

// Combo system
self.combo = 0;
self.combo_timer = 0;
self.combo_timeout = 30; // Frames before combo resets

// Spawn blocks from level data or random generation
if (_level_data.layout != undefined) {
    scr_spawn_level_blocks(_level_data.layout);

    // Spawn power-ups for test level
    if (variable_struct_exists(_level_data, "spawn_powerups") && _level_data.spawn_powerups) {
        var _y = self.grid_start_y + 6 * self.grid_cell_size;
        var _spacing = self.grid_cell_size;
        var _start_x = room_width / 2 - _spacing * 1.5;

        for (var i = 0; i < 4; i++) {
            var _p = instance_create_layer(_start_x + i * _spacing, _y, "instances", obj_power_up);
            _p.type = i;
            _p.image_index = i;
        }
    }
} else {
    // Random generation for levels beyond 9
    scr_spawn_blocks_row(false);
    scr_move_blocks_down();
    scr_spawn_blocks_row(false);
    scr_move_blocks_down();
    scr_spawn_blocks_row(false);
    scr_move_blocks_down();
    scr_spawn_blocks_row();
    scr_move_blocks_down();
}