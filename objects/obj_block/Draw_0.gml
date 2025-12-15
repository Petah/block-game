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
