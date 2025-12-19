if (array_length(self._children) == 0) {
    var _children = scr_button_level_create(self._level_data);
    for (var _i = 0; _i < array_length(_children); _i++) {
        var _level_data = _children[_i];
        var _instance = scr_button_level_create_instance(_level_data, self, _level_data.x, _level_data.y);
    }
    scr_save();
}