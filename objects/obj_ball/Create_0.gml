// Ball speed (used for initial impulse calculation)
self.ball_speed = 800; // Physics uses larger values

// Bonus ball flag (created from split, won't split again)
self.is_bonus = false;

// Power-up states
self.fireball = false;   // Pass through blocks without bouncing
self.will_split = false; // Split into 2 balls on next block hit

// Physics is set on the object, but we can adjust properties here
phy_bullet = true; // Prevent tunneling through thin objects
