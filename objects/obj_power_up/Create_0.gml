// Power-up types (matches sprite frame index)
// 0 = extra ball (+1)
// 1 = fireball (pass through blocks)
// 2 = split (ball splits on first hit)
// 3 = big ball (larger collision)

// Type will be set by spawner, default to extra ball
self.type = 0;
image_index = self.type;
image_speed = 0; // Don't animate, use fixed frame

// Assign sprite
sprite_index = spr_power_up;

// Track which balls have already collected this power-up
self.collected_by = [];

// Scale block to fit grid cell size
image_xscale = obj_game.grid_cell_size / sprite_width * 0.8;
image_yscale = obj_game.grid_cell_size / sprite_height * 0.8;