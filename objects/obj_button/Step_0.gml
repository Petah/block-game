// Check if mouse is over button
var _mx = mouse_x;
var _my = mouse_y;

var _left = x - self.width / 2;
var _right = x + self.width / 2;
var _top = y - self.height / 2;
var _bottom = y + self.height / 2;

self.hovered = (_mx >= _left && _mx <= _right && _my >= _top && _my <= _bottom);

// Handle click
if (self.hovered)
{
    if (mouse_check_button_pressed(mb_left))
    {
        self.pressed = true;
    }
    
    if (mouse_check_button_released(mb_left) && self.pressed)
    {
        // Trigger callback
        if (self.on_click != undefined)
        {
            self.on_click();
        }
        self.pressed = false;
    }
}

// Reset pressed if mouse released outside
if (mouse_check_button_released(mb_left))
{
    self.pressed = false;
}
