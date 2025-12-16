draw_self();

// Draw health number (except for steel blocks which are indestructible)
if (self.block_type != "steel") {
    scr_draw_text(x, y, string(self.health), {
        color: c_white,
        halign: fa_center,
        valign: fa_middle
    });
}
