// Button properties
self.text = "Button";
self.width = 200;
self.height = 50;

// State
self.hovered = false;
self.pressed = false;

// Level button properties
self.locked = false;
self.stars = 0;
self.level_num = 0;

// Callback (set by creator)
self.on_click = undefined;

// Set up 9-slice for the sprite
var _ns = sprite_get_nineslice(spr_button);
_ns.enabled = true;
_ns.left = 16;
_ns.right = 16;
_ns.top = 16;
_ns.bottom = 16;
