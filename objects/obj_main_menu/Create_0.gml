// Viewport drag variables
self._dragging = false;
self._drag_start_x = 0;
self._drag_start_y = 0;
self._drag_cam_start_x = 0;
self._drag_cam_start_y = 0;

instance_create_layer(0, 0, "ui_under", obj_level_lines);

var _loaded = src_load();
log_info("Loaded level {0}", _loaded);
if (!_loaded) {
    self._root = scr_button_level_create_instance(scr_init_level_data(), undefined, room_width / 2, room_height / 2);
    array_push(global._game_state, self._root._level_data);

    var _left = scr_button_level_create_instance(scr_button_level_enhance(self._root._level_data, "More Balls"), self._root, room_width / 2 - global._level_spacing, room_height / 2);
    array_push(global._game_state, _left._level_data);

    var _right = scr_button_level_create_instance(scr_button_level_enhance(self._root._level_data, "Bigger Level"), self._root, room_width / 2 + global._level_spacing, room_height / 2);
    array_push(global._game_state, _right._level_data);

    var _up = scr_button_level_create_instance(scr_button_level_enhance(self._root._level_data, "Stronger Blocks"), self._root, room_width / 2, room_height / 2 - global._level_spacing);
    array_push(global._game_state, _up._level_data);

    var _down = scr_button_level_create_instance(scr_button_level_enhance(self._root._level_data, "More Steel"), self._root, room_width / 2, room_height / 2 + global._level_spacing);
    array_push(global._game_state, _down._level_data);

    self._root._level_data.children = [_left._level_data.index, _right._level_data.index, _up._level_data.index, _down._level_data.index];
    self._root._children = [_left, _right, _up, _down];

    scr_save();
} else {
    self._root = _loaded;
}

if (variable_global_exists("_generated_level") && global._generated_level.level_data.index) {
    for (var _i = 0; _i < array_length(global._game_state); _i++) {
        var _level_data = global._game_state[_i];
        if (_level_data.index == global._generated_level.level_data.index) {
            var _cam_x = _level_data.x - room_width / 2;
            var _cam_y = _level_data.y - room_height / 2;
            camera_set_view_pos(view_camera[0], _cam_x, _cam_y);
            break;
        }
    }
}