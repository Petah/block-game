function src_load() {
    // global._game_state = [];
    // return undefined;
    global._game_state = src_json_file_read("save.json");
    log_info("Loaded JSON array: {0}", array_length(global._game_state));

    var _root = undefined;
    var _instances = {};
    for (var _i = array_length(global._game_state) - 1; _i >= 0; _i--) {
        var _data = global._game_state[_i];
        log_info("Loading button level {0} {1}", _i, _data);
        var _instance = instance_create_layer(_data.x, _data.y, "ui", obj_button_level);
        _instance._level_data = scr_init_level_data();

        var _keys = variable_struct_get_names(_data);
        for (var _k = array_length(_keys) - 1; _k >= 0; --_k) {
            _instance._level_data[$ _keys[_k]] = _data[$ _keys[_k]];
        }

        if (_instance._level_data.icon != -1) {
            _instance._icon = asset_get_index(_instance._level_data.icon);
        }

        _instances[$ _instance._level_data.index] = _instance;

        for (var _c = 0; _c < array_length(_data.children); _c++) {
            var _child_index = _data.children[_c];
            array_push(_instance._children, _instances[$ _child_index]);
            _instances[$ _child_index]._parent = _instance;
        }
        _root = _instance;
    }

    return _root;
}