// Click and drag to move viewport
var _gui_mouse_x = device_mouse_x_to_gui(0);
var _gui_mouse_y = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) {
    self._drag_start_x = _gui_mouse_x;
    self._drag_start_y = _gui_mouse_y;
    self._drag_cam_start_x = camera_get_view_x(view_camera[0]);
    self._drag_cam_start_y = camera_get_view_y(view_camera[0]);
    self._dragging = true;
}

if (mouse_check_button(mb_left) && self._dragging) {
    var _dx = self._drag_start_x - _gui_mouse_x;
    var _dy = self._drag_start_y - _gui_mouse_y;
    camera_set_view_pos(view_camera[0], self._drag_cam_start_x + _dx, self._drag_cam_start_y + _dy);
}

if (mouse_check_button_released(mb_left)) {
    self._dragging = false;
}