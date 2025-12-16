// Ball speed
self.ball_speed = 8;

// Power-up states
self.fireball = false;   // Pass through blocks without bouncing
self.will_split = false; // Split into 2 balls on next block hit

// Auto-death timer (frames since last block hit)
self.idle_timer = 0;
self.idle_timeout = 60 * 12; // 12 seconds at 60fps
