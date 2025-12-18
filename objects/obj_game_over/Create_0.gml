self._panel_w = 400;
self._panel_h = 350;
self._panel_x = room_width / 2 - _panel_w / 2;
self._panel_y = room_height / 2 - _panel_h / 2;
self._pad = 16;

// Save high score when game ends
scr_update_high_score(obj_game.score);

// Buttons
self.skip = scr_button_create(self._panel_x + self._pad, self._panel_y + 200, self._panel_w - 2 * self._pad, 62, "SKIP LEVEL", function() {
    global.selected_level = obj_game.level + 1;
    room_restart();
});
self.back = scr_button_create(self._panel_x + self._pad, self._panel_y + 270, self._panel_w - 2 * self._pad, 62, "BACK", function() {
    room_goto(rm_main_menu);
});
self.extra_balls = scr_button_create(self._panel_x + self._pad, self._panel_y + 130, self._panel_w - 2 * self._pad, 62, "+5 EXTRA BALLS", function() {
    obj_game.balls += 5;
    // No stars awarded for this level
    room_restart();
});