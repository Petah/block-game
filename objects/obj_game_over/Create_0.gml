self._panel_w = 400;
self._panel_h = 350;
self._panel_x = room_width / 2 - _panel_w / 2;
self._panel_y = room_height / 2 - _panel_h / 2;
self._pad = 16;
self._buttons = [];

// Buttons
scr_button_create(self._buttons, self._panel_x + self._pad, self._panel_y + 200, self._panel_w - 2 * self._pad, 62, "SKIP LEVEL", function() {
    // @todo give 2 choices for next levels
    room_restart();
});
scr_button_create(self._buttons, self._panel_x + self._pad, self._panel_y + 270, self._panel_w - 2 * self._pad, 62, "BACK", function() {
    room_goto(rm_main_menu);
});
scr_button_create(self._buttons, self._panel_x + self._pad, self._panel_y + 130, self._panel_w - 2 * self._pad, 62, "+5 EXTRA BALLS", function() {
    // Add to cumulative extra balls count
    if (!variable_global_exists("extra_balls_count"))
    {
        global.extra_balls_count = 0;
    }
    global.extra_balls_count += 5;

    // Set flag to add extra balls on restart (checked in obj_game Create)
    global.restart_with_extra_balls = true;

    // Restart the level
    room_restart();
});