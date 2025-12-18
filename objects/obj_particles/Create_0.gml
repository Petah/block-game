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

// Firework particles (for level complete celebration)
self.part_firework = part_type_create();
part_type_shape(self.part_firework, pt_shape_star);
part_type_size(self.part_firework, 0.3, 0.8, -0.01, 0);
part_type_color3(self.part_firework, c_white, c_yellow, c_fuchsia);
part_type_alpha3(self.part_firework, 1, 0.8, 0);
part_type_speed(self.part_firework, 5, 12, -0.15, 0);
part_type_direction(self.part_firework, 0, 360, 0, 0);
part_type_life(self.part_firework, 40, 70);
part_type_gravity(self.part_firework, 0.1, 270);

// Firework sparks (secondary particles)
self.part_firework_spark = part_type_create();
part_type_shape(self.part_firework_spark, pt_shape_pixel);
part_type_size(self.part_firework_spark, 0.5, 1.5, -0.02, 0);
part_type_color3(self.part_firework_spark, c_aqua, c_lime, c_yellow);
part_type_alpha3(self.part_firework_spark, 1, 0.6, 0);
part_type_speed(self.part_firework_spark, 3, 8, -0.1, 0);
part_type_direction(self.part_firework_spark, 0, 360, 0, 0);
part_type_life(self.part_firework_spark, 30, 50);
part_type_gravity(self.part_firework_spark, 0.2, 270);

// === BALL TYPE PARTICLES ===

// Metallic ball trail (chrome shards)
self.part_metallic_trail = part_type_create();
part_type_shape(self.part_metallic_trail, pt_shape_square);
part_type_size(self.part_metallic_trail, 0.2, 0.5, -0.02, 0);
part_type_color3(self.part_metallic_trail, c_white, c_silver, c_gray);
part_type_alpha3(self.part_metallic_trail, 0.8, 0.4, 0);
part_type_speed(self.part_metallic_trail, 1, 3, -0.1, 0);
part_type_direction(self.part_metallic_trail, 0, 360, 0, 0);
part_type_orientation(self.part_metallic_trail, 0, 360, 10, 0, false);
part_type_life(self.part_metallic_trail, 10, 20);

// Heavy ball trail (dark debris)
self.part_heavy_trail = part_type_create();
part_type_shape(self.part_heavy_trail, pt_shape_square);
part_type_size(self.part_heavy_trail, 0.3, 0.6, -0.01, 0);
part_type_color3(self.part_heavy_trail, c_dkgray, make_color_rgb(45, 45, 45), c_black);
part_type_alpha3(self.part_heavy_trail, 0.7, 0.4, 0);
part_type_speed(self.part_heavy_trail, 0.5, 2, -0.05, 0);
part_type_direction(self.part_heavy_trail, 240, 300, 0, 0);
part_type_life(self.part_heavy_trail, 15, 25);
part_type_gravity(self.part_heavy_trail, 0.3, 270);

// Gooey ball trail (slime drips)
self.part_gooey_trail = part_type_create();
part_type_shape(self.part_gooey_trail, pt_shape_circle);
part_type_size(self.part_gooey_trail, 0.3, 0.7, -0.01, 0);
part_type_color3(self.part_gooey_trail, make_color_rgb(167, 243, 208), make_color_rgb(52, 211, 153), make_color_rgb(5, 150, 105));
part_type_alpha3(self.part_gooey_trail, 0.7, 0.5, 0);
part_type_speed(self.part_gooey_trail, 0.5, 1.5, -0.02, 0);
part_type_direction(self.part_gooey_trail, 250, 290, 0, 0);
part_type_life(self.part_gooey_trail, 20, 35);
part_type_gravity(self.part_gooey_trail, 0.15, 270);

// Lightning ball trail (electric sparks)
self.part_lightning_trail = part_type_create();
part_type_shape(self.part_lightning_trail, pt_shape_spark);
part_type_size(self.part_lightning_trail, 0.2, 0.6, -0.03, 0);
part_type_color3(self.part_lightning_trail, c_white, c_yellow, make_color_rgb(250, 204, 21));
part_type_alpha3(self.part_lightning_trail, 1, 0.6, 0);
part_type_speed(self.part_lightning_trail, 2, 6, -0.2, 0);
part_type_direction(self.part_lightning_trail, 0, 360, 0, 30);
part_type_orientation(self.part_lightning_trail, 0, 360, 20, 0, false);
part_type_life(self.part_lightning_trail, 5, 12);

// Ice ball trail (frost crystals)
self.part_ice_trail = part_type_create();
part_type_shape(self.part_ice_trail, pt_shape_star);
part_type_size(self.part_ice_trail, 0.2, 0.5, -0.02, 0);
part_type_color3(self.part_ice_trail, c_white, make_color_rgb(125, 211, 252), make_color_rgb(2, 132, 199));
part_type_alpha3(self.part_ice_trail, 0.8, 0.5, 0);
part_type_speed(self.part_ice_trail, 1, 3, -0.1, 0);
part_type_direction(self.part_ice_trail, 0, 360, 0, 0);
part_type_orientation(self.part_ice_trail, 0, 360, 5, 0, false);
part_type_life(self.part_ice_trail, 15, 25);

// Plasma ball trail (energy wisps)
self.part_plasma_trail = part_type_create();
part_type_shape(self.part_plasma_trail, pt_shape_flare);
part_type_size(self.part_plasma_trail, 0.3, 0.7, -0.02, 0);
part_type_color3(self.part_plasma_trail, make_color_rgb(240, 171, 252), make_color_rgb(192, 38, 211), make_color_rgb(107, 33, 168));
part_type_alpha3(self.part_plasma_trail, 0.8, 0.5, 0);
part_type_speed(self.part_plasma_trail, 1, 4, -0.1, 0);
part_type_direction(self.part_plasma_trail, 0, 360, 0, 15);
part_type_life(self.part_plasma_trail, 12, 20);

// Shadow ball trail (dark wisps)
self.part_shadow_trail = part_type_create();
part_type_shape(self.part_shadow_trail, pt_shape_smoke);
part_type_size(self.part_shadow_trail, 0.3, 0.8, -0.01, 0);
part_type_color3(self.part_shadow_trail, make_color_rgb(75, 85, 99), make_color_rgb(31, 41, 55), make_color_rgb(3, 7, 18));
part_type_alpha3(self.part_shadow_trail, 0.5, 0.3, 0);
part_type_speed(self.part_shadow_trail, 0.5, 2, -0.05, 0);
part_type_direction(self.part_shadow_trail, 0, 360, 0, 5);
part_type_life(self.part_shadow_trail, 20, 35);

// Shadow ball eyes (purple glints)
self.part_shadow_eyes = part_type_create();
part_type_shape(self.part_shadow_eyes, pt_shape_pixel);
part_type_size(self.part_shadow_eyes, 0.5, 1.0, -0.02, 0);
part_type_color3(self.part_shadow_eyes, make_color_rgb(168, 85, 247), make_color_rgb(107, 33, 168), c_black);
part_type_alpha3(self.part_shadow_eyes, 0.9, 0.5, 0);
part_type_speed(self.part_shadow_eyes, 1, 3, -0.1, 0);
part_type_direction(self.part_shadow_eyes, 0, 360, 0, 0);
part_type_life(self.part_shadow_eyes, 10, 18);
