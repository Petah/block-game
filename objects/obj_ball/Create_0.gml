// Ball speed
self.ball_speed = 8;

// Direction will be set by the launcher
hspeed = 0;
vspeed = 0;

// Power-up states
self.fireball = false;   // Pass through blocks without bouncing
self.will_split = false; // Split into 2 balls on next block hit

// Auto-death timer (frames since last block hit)
self.idle_timer = 0;
self.idle_timeout = 60 * 8; // 8 seconds at 60fps
