draw_set_alpha(0.7);
with (obj_button_level) {
    if (self._parent != noone) {
        draw_line_width_colour(self.x, self.y, self._parent.x, self._parent.y, 2, c_white, c_white);
    }
}
