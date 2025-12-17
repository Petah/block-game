// Don't process if not visible
if (!visible) exit;

// Check if mouse is over button
var _mx = mouse_x;
var _my = mouse_y;

var _left = x - self.width / 2;
var _right = x + self.width / 2;
var _top = y - self.height / 2;
var _bottom = y + self.height / 2;

self.hovered = (_mx >= _left && _mx <= _right && _my >= _top && _my <= _bottom);

// Check if main menu is scrolling (don't trigger click while scrolling)
var _is_scrolling = false;
if (instance_exists(obj_main_menu)) {
    _is_scrolling = obj_main_menu.is_dragging;
}

// Handle click
if (self.hovered)
{
    if (mouse_check_button_pressed(mb_left) && !_is_scrolling)
    {
        self.pressed = true;
    }

    if (mouse_check_button_released(mb_left) && self.pressed && !_is_scrolling)
    {
        // Trigger callback
        if (self.on_click != undefined)
        {
            self.on_click();
        }
        self.pressed = false;
    }
}

// Reset pressed if mouse released outside or scrolling started
if (mouse_check_button_released(mb_left) || _is_scrolling)
{
    self.pressed = false;
}
