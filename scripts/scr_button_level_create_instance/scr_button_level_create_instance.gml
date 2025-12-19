function scr_button_level_create_instance(_level_data, _parent, _x, _y) {
    var _instance = instance_create_layer(_x, _y, "ui", obj_button_level);
    if (_level_data) {
        _instance._level_data = _level_data;
    }
    if (_parent) {
        _instance._parent = _parent;
    }
    _instance._level_data.x = _x;
    _instance._level_data.y = _y;
    _instance._icon = asset_get_index(_instance._level_data.icon);
    return _instance;
}