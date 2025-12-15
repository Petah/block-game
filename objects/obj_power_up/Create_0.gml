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
