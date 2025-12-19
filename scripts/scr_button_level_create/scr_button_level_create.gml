function scr_button_level_create(_parent_level_data) {
    var _parent_direction = point_direction(room_width / 2, room_height / 2, _parent_level_data.x, _parent_level_data.y);
    var _angle = 35;
    var _children = [];

    var _x = _parent_level_data.x + lengthdir_x(global._level_spacing, _parent_direction + _angle);
    var _y = _parent_level_data.y + lengthdir_y(global._level_spacing, _parent_direction + _angle);
    if (scr_button_level_create_place_free(_x, _y)) {
        var _left = scr_button_level_enhance(_parent_level_data, undefined, 1);
        _left.x = _x;
        _left.y = _y;
        array_push(_parent_level_data.children, _left.index);
        array_push(_children, _left);
        array_push(global._game_state, _left);
    }

    var _x = _parent_level_data.x + lengthdir_x(global._level_spacing, _parent_direction - _angle);
    var _y = _parent_level_data.y + lengthdir_y(global._level_spacing, _parent_direction - _angle);
    if (scr_button_level_create_place_free(_x, _y)) {
        var _right = scr_button_level_enhance(_parent_level_data, undefined, 2);
        _right.x = _x;
        _right.y = _y;
        array_push(_parent_level_data.children, _right.index);
        array_push(_children, _right);
        array_push(global._game_state, _right);
    }

    // @todo make dead ends much harder

    return _children;
}

function scr_button_level_create_place_free(_x, _y) {
    for (var _i = 0; _i < array_length(global._game_state); _i++) {
        var _level_data = global._game_state[_i];
        var _dist = point_distance(_x, _y, _level_data.x, _level_data.y);
        if (_dist < 70) {
            return false;
        }
    }
    return true;
}
