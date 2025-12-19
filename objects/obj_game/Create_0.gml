// Spawn debug overlay
instance_create_layer(0, 0, "ui", obj_debug);

// Game variables
self.score = 0;
self.game_over = false;
self.game_won = false;
self.level_complete = false;
self.stars_earned = 0;
self._turns = 0;
self.lives = 3; // Player lives
self.used_extra_balls = false; // Track if player used extra balls (no stars if true)

// Check if restarting with extra balls
if (variable_global_exists("restart_with_extra_balls") && global.restart_with_extra_balls)
{
    self.used_extra_balls = true;
    global.restart_with_extra_balls = false; // Reset flag
}
else
{
    // Reset extra balls count when starting level fresh
    global.extra_balls_count = 0;
}

// Ball shooting system (slingshot style with burst fire)
self.num_balls = global._generated_level.balls; // Total balls available

// Add extra balls if restarting with extra balls option
if (self.used_extra_balls && variable_global_exists("extra_balls_count"))
{
    self.num_balls += global.extra_balls_count;
}

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


// Back button bounds (for click detection)
self.back_btn_x = 10;
self.back_btn_y = 10;
self.back_btn_w = 70;
self.back_btn_h = 70;

// Grid settings - cols based on level layout or default for random
self.grid_cols = array_length(global._generated_level.layout[0]);
self.grid_cell_size = room_width / self.grid_cols;
self.grid_start_x = self.grid_cell_size / 2; // First column center
self.grid_start_y = global._header_height + self.grid_cell_size / 2; // Below header bar

// Calculate grid_bottom_y aligned to grid (leave room for shooter at bottom)
var _available_height = room_height - global._header_height - global._danger_zone_size;
var _num_rows = floor(_available_height / self.grid_cell_size);
self.grid_bottom_y = global._header_height + (_num_rows * self.grid_cell_size); // Aligned to grid

// Spawn danger zone
instance_create_layer(0, 0, "bg_instances", obj_danger_zone);
obj_danger_zone.x = room_width / 2;
obj_danger_zone.y = room_height - global._danger_zone_size;

// Spawn physics walls (left, right, top)
var _wall_thickness = 32;

// Left wall
scr_create_wall(-_wall_thickness, 0, _wall_thickness, room_height);

// Right wall
scr_create_wall(room_width, 0, _wall_thickness, room_height);

// Top wall (below header)
scr_create_wall(0, global._header_height - _wall_thickness, room_width, _wall_thickness);

// Spawn particle system manager
instance_create_layer(0, 0, "bg_instances", obj_particles);

// Spawn screen shake manager
instance_create_layer(0, 0, "bg_instances", obj_screen_shake);

// Combo system
self.combo = 0;
self.combo_timer = 0;
self.combo_timeout = 30; // Frames before combo resets

// Spawn blocks from level data or random generation
scr_spawn_level_blocks(global._generated_level.layout);
