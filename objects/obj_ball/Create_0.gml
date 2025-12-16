// Ball speed
self.ball_speed = 8;

// Bonus ball flag (created from split, won't split again)
self.is_bonus = false;

// Power-up states
self.fireball = false;   // Pass through blocks without bouncing
self.will_split = false; // Split into 2 balls on next block hit

show_debug_message("Ball created. ID: " + string(self.id));