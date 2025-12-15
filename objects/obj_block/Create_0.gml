// Block health - will be set by obj_game when created
self.health = 1;

// Don't animate - we set frame based on health
image_speed = 0;

// Scale block to fit grid cell size
image_xscale = obj_game.grid_cell_size / sprite_width;
image_yscale = obj_game.grid_cell_size / sprite_height;