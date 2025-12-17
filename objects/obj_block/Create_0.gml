// Default values - use scr_spawn_block() to create blocks with proper initialization
self.health = 1;
self.block_type = "normal";

// Rainbow block regeneration
self.initial_health = 1;
self.regen_timer = 0;
self.regen_interval = 60; // Frames between health regen (1 second at 60fps)
