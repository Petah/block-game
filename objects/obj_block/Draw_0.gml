// Set sprite frame based on health (7 frames: 0-6)
// Higher health = higher frame index
if (self.health <= 2) image_index = 0;       // Blue
else if (self.health <= 4) image_index = 1;  // Green
else if (self.health <= 6) image_index = 2;  // Yellow
else if (self.health <= 9) image_index = 3;  // Orange
else if (self.health <= 12) image_index = 4; // Red
else if (self.health <= 16) image_index = 5; // Purple
else image_index = 6;                         // Pink

// Draw the block sprite
draw_self();

// Draw health number on top of block
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1);
draw_text(x, y, string(self.health));

// Reset alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);
