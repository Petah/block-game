// Screen shake
self.shake_amount = 0;
self.shake_x = 0;
self.shake_y = 0;

// Camera for screen shake
self.cam = camera_create_view(0, 0, room_width, room_height);
view_enabled = true;
view_visible[0] = true;
view_camera[0] = self.cam;
