// Particle system
self.part_sys = part_system_create();
part_system_depth(self.part_sys, -100); // Draw above everything

// Block hit particles (small burst)
self.part_block_hit = part_type_create();
part_type_shape(self.part_block_hit, pt_shape_square);
part_type_size(self.part_block_hit, 0.2, 0.5, -0.02, 0);
part_type_color3(self.part_block_hit, c_white, c_yellow, c_orange);
part_type_alpha3(self.part_block_hit, 1, 0.8, 0);
part_type_speed(self.part_block_hit, 2, 5, -0.1, 0);
part_type_direction(self.part_block_hit, 0, 360, 0, 0);
part_type_life(self.part_block_hit, 15, 25);

// Block destroy particles (big explosion)
self.part_block_destroy = part_type_create();
part_type_shape(self.part_block_destroy, pt_shape_square);
part_type_size(self.part_block_destroy, 0.3, 0.8, -0.02, 0);
part_type_color3(self.part_block_destroy, c_white, c_lime, c_green);
part_type_alpha3(self.part_block_destroy, 1, 0.7, 0);
part_type_speed(self.part_block_destroy, 3, 7, -0.15, 0);
part_type_direction(self.part_block_destroy, 0, 360, 0, 0);
part_type_life(self.part_block_destroy, 20, 40);
part_type_gravity(self.part_block_destroy, 0.1, 270);

// Power-up collect particles (sparkle)
self.part_powerup = part_type_create();
part_type_shape(self.part_powerup, pt_shape_star);
part_type_size(self.part_powerup, 0.3, 0.6, -0.01, 0);
part_type_color3(self.part_powerup, c_white, c_aqua, c_blue);
part_type_alpha3(self.part_powerup, 1, 0.8, 0);
part_type_speed(self.part_powerup, 1, 3, -0.05, 0);
part_type_direction(self.part_powerup, 0, 360, 0, 0);
part_type_life(self.part_powerup, 30, 50);

// Ball trail particles
self.part_ball_trail = part_type_create();
part_type_shape(self.part_ball_trail, pt_shape_circle);
part_type_size(self.part_ball_trail, 0.2, 0.4, -0.02, 0);
part_type_color3(self.part_ball_trail, c_red, c_orange, c_yellow);
part_type_alpha3(self.part_ball_trail, 0.5, 0.3, 0);
part_type_life(self.part_ball_trail, 10, 15);

// Fireball trail particles (bigger, more intense)
self.part_fire_trail = part_type_create();
part_type_shape(self.part_fire_trail, pt_shape_flare);
part_type_size(self.part_fire_trail, 0.4, 0.8, -0.03, 0);
part_type_color3(self.part_fire_trail, c_yellow, c_orange, c_red);
part_type_alpha3(self.part_fire_trail, 0.8, 0.5, 0);
part_type_speed(self.part_fire_trail, 0.5, 2, -0.05, 0);
part_type_direction(self.part_fire_trail, 250, 290, 0, 10);
part_type_life(self.part_fire_trail, 15, 25);
part_type_gravity(self.part_fire_trail, 0.05, 90);

// Fire block destroy particles (explosive orange/red)
self.part_fire_destroy = part_type_create();
part_type_shape(self.part_fire_destroy, pt_shape_flare);
part_type_size(self.part_fire_destroy, 0.4, 1.0, -0.03, 0);
part_type_color3(self.part_fire_destroy, c_white, c_orange, c_red);
part_type_alpha3(self.part_fire_destroy, 1, 0.6, 0);
part_type_speed(self.part_fire_destroy, 4, 9, -0.2, 0);
part_type_direction(self.part_fire_destroy, 0, 360, 0, 0);
part_type_life(self.part_fire_destroy, 20, 35);
part_type_gravity(self.part_fire_destroy, 0.15, 270);
