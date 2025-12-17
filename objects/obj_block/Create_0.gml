// Default values - use scr_spawn_block() to create blocks with proper initialization
self.health = 1;
self.block_type = "normal";

// Home position for spring-back effect (set by scr_spawn_block)
self.home_x = x;
self.home_y = y;

// Rainbow block regeneration
self.initial_health = 1;
self.regen_timer = 0;
self.regen_interval = 60; // Frames between health regen (1 second at 60fps)
