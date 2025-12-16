// Use dedicated sprite for special block types
switch (self.block_type)
{
    case "explosive":
        sprite_index = spr_block_explosive;
        image_index = 0;
        break;
    case "steel":
        sprite_index = spr_block_steel;
        image_index = 0;
        break;
    case "rainbow":
        sprite_index = spr_block_rainbow;
        image_index = 0;
        break;
    default:
        sprite_index = spr_block;
        // Set sprite frame based on health (7 frames: 0-6)
        if (self.health <= 2) image_index = 0;       // Blue
        else if (self.health <= 4) image_index = 1;  // Green
        else if (self.health <= 6) image_index = 2;  // Yellow
        else if (self.health <= 9) image_index = 3;  // Orange
        else if (self.health <= 12) image_index = 4; // Red
        else if (self.health <= 16) image_index = 5; // Purple
        else image_index = 6;                         // Pink
        image_blend = c_white;
        break;
}

// Draw the block sprite
draw_self();

// Reset blend
image_blend = c_white;

// Draw health number or symbol on top of block
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1);

if (self.block_type == "steel")
{
    // Steel blocks don't show health (indestructible)
}
else
{
    draw_text(x, y, string(self.health));
}

// Reset alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);
