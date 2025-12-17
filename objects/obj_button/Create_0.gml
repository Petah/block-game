// Button properties
self.text = "Button";
self.width = 200;
self.height = 50;

// State
self.hovered = false;
self.pressed = false;
self.press_start_y = 0; // For scroll detection

// Level button properties
self.locked = false;
self.stars = 0;
self.level_num = 0;
self.base_y = y; // For scrolling in menus

// Callback (set by creator)
self.on_click = undefined;
