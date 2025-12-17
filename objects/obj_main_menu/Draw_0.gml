// Draw background gradient
draw_rectangle_color(0, 0, room_width, room_height,
    make_color_rgb(15, 15, 35),  // Top: #0f0f23
    make_color_rgb(15, 15, 35),
    make_color_rgb(26, 26, 46),  // Bottom: #1a1a2e
    make_color_rgb(26, 26, 46),
    false);

// Draw title
scr_draw_text(room_width / 2, 80, "BLOCK GAME", {
    font: fnt_xl,
    color: c_white,
    halign: fa_center,
    valign: fa_middle
});

// Draw subtitle
scr_draw_text(room_width / 2, 160, "SELECT LEVEL", {
    font: fnt_lg,
    color: make_color_rgb(150, 150, 180),
    halign: fa_center,
    valign: fa_middle
});

// Draw progress info
var _unlocked = 0;
for (var i = 1; i <= self.total_levels; i++) {
    if (scr_is_level_unlocked(i)) _unlocked++;
}
scr_draw_text(room_width / 2, 210, string(_unlocked) + " / " + string(self.total_levels) + " unlocked", {
    font: fnt_sm,
    color: make_color_rgb(100, 100, 140),
    halign: fa_center,
    valign: fa_middle
});

// Draw fade gradients at top and bottom of scroll area
draw_set_alpha(1);

// Top fade
for (var i = 0; i < 40; i++) {
    var _alpha = 1 - (i / 40);
    draw_set_color(make_color_rgb(15, 15, 35));
    draw_set_alpha(_alpha);
    draw_line(0, self.visible_top + i, room_width, self.visible_top + i);
}

// Bottom fade
for (var i = 0; i < 40; i++) {
    var _alpha = i / 40;
    draw_set_color(make_color_rgb(26, 26, 46));
    draw_set_alpha(_alpha);
    draw_line(0, self.visible_bottom - 40 + i, room_width, self.visible_bottom - 40 + i);
}

draw_set_alpha(1);

// Draw scroll bar on right side
if (self.scroll_max > 0) {
    var _bar_x = room_width - 20;
    var _bar_top = self.visible_top + 50;
    var _bar_height = self.visible_bottom - self.visible_top - 100;
    var _thumb_height = max(40, _bar_height * (_bar_height / (_bar_height + self.scroll_max)));
    var _scroll_ratio = self.scroll_y / self.scroll_max;
    var _thumb_y = _bar_top + _scroll_ratio * (_bar_height - _thumb_height);

    // Bar background
    draw_set_color(make_color_rgb(40, 40, 60));
    draw_set_alpha(0.5);
    draw_roundrect(_bar_x - 4, _bar_top, _bar_x + 4, _bar_top + _bar_height, false);

    // Thumb
    draw_set_color(make_color_rgb(100, 100, 150));
    draw_set_alpha(0.8);
    draw_roundrect(_bar_x - 4, _thumb_y, _bar_x + 4, _thumb_y + _thumb_height, false);

    draw_set_alpha(1);
}

// Draw scroll hint at bottom if more content below
if (self.scroll_y < self.scroll_max - 10) {
    var _hint_alpha = 0.5 + sin(current_time / 300) * 0.3;
    scr_draw_text(room_width / 2, room_height - 30, "Scroll for more levels", {
        font: fnt_sm,
        color: make_color_rgb(150, 150, 180),
        halign: fa_center,
        alpha: _hint_alpha
    });
}
