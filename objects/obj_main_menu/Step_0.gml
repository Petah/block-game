// Handle scrolling for level select

// Mouse/touch drag scrolling
if (mouse_check_button_pressed(mb_left)) {
    // Only start potential drag if within the scrollable area
    if (mouse_y > self.visible_top && mouse_y < self.visible_bottom) {
        self.drag_start_y = mouse_y;
        self.drag_start_scroll = self.scroll_y;
        self.mouse_down = true;
        self.is_dragging = false; // Not dragging yet, just pressed
    }
}

if (mouse_check_button(mb_left) && self.mouse_down) {
    var _delta = self.drag_start_y - mouse_y;

    // Only start dragging after moving enough (threshold of 15 pixels)
    if (!self.is_dragging && abs(_delta) > 15) {
        self.is_dragging = true;
        self.scroll_velocity = 0;
    }

    // Only scroll if actually dragging
    if (self.is_dragging) {
        self.scroll_target = self.drag_start_scroll + _delta;
        self.scroll_target = clamp(self.scroll_target, self.scroll_min, self.scroll_max);

        // Track velocity for momentum
        self.scroll_velocity = (self.scroll_target - self.scroll_y);
    }
}

if (mouse_check_button_released(mb_left)) {
    self.mouse_down = false;
    self.is_dragging = false;
}

// Mouse wheel scrolling
var _wheel = mouse_wheel_down() - mouse_wheel_up();
if (_wheel != 0) {
    self.scroll_target += _wheel * 60;
    self.scroll_target = clamp(self.scroll_target, self.scroll_min, self.scroll_max);
}

// Apply momentum when not dragging
if (!self.is_dragging) {
    // Apply friction to velocity
    self.scroll_velocity *= 0.92;

    // Apply velocity to scroll target
    if (abs(self.scroll_velocity) > 0.5) {
        self.scroll_target += self.scroll_velocity * 0.3;
        self.scroll_target = clamp(self.scroll_target, self.scroll_min, self.scroll_max);
    }
}

// Smooth scroll to target
self.scroll_y = lerp(self.scroll_y, self.scroll_target, 0.25);

// Update button positions based on scroll
for (var i = 0; i < array_length(self.level_buttons); i++) {
    var _btn = self.level_buttons[i];
    if (instance_exists(_btn)) {
        _btn.y = _btn.base_y - self.scroll_y;

        // Hide buttons outside visible area (disable interaction)
        var _btn_top = _btn.y - _btn.height / 2;
        var _btn_bottom = _btn.y + _btn.height / 2;
        _btn.visible = (_btn_bottom > self.visible_top && _btn_top < self.visible_bottom);
    }
}
