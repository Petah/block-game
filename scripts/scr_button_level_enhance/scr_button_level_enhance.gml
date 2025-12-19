function scr_button_level_enhance(_button_level_data, _fixed_enhancement, _count) {
    random_set_seed(_button_level_data.seed);

    var _enhancements = [
        "More Balls",
        "Bigger Level",
        "Stronger Blocks",
        "More Steel",
        "More Rainbow",
        "More Explosive",
    ];
    var _new_level_data = variable_clone(_button_level_data);
    _new_level_data.level += 1;
    _new_level_data.children = [];
    _new_level_data.seed = array_length(global._game_state) + 1;
    _new_level_data.index = string(array_length(global._game_state) + 1);

    if (_fixed_enhancement != undefined) {
        _new_level_data.enhancement = _fixed_enhancement;
    } else {
        for (var _i = 0; _i < _count; _i++) {
            var _index = irandom_range(0, array_length(_enhancements) - 1);
            _new_level_data.enhancement = _enhancements[_index];
            array_delete(_enhancements, _index, 1);
        }
    }

    switch (_new_level_data.enhancement) {
        case "More Balls":
            _new_level_data.min_balls += 1;
            _new_level_data.max_balls += 2;
            _new_level_data.icon = "spr_ball";
            // _button._icon = spr_ball;
            break;
        case "Bigger Level":
            if (random(1) < 0.5) {
                _new_level_data.min_width += 1;
                _new_level_data.max_width += 2;
                _new_level_data.icon = "spr_block";
                // _button._icon = spr_block;
            } else {
                _new_level_data.min_height += 1;
                _new_level_data.max_height += 2;
                _new_level_data.icon = "spr_block";
                // _button._icon = spr_block;
            }
            break;
        case "Stronger Blocks":
            _new_level_data.min_health += 1;
            _new_level_data.max_health += 2;
            _new_level_data.icon = "spr_heart";
            // _button._icon = spr_heart;
            break;
        case "More Steel":
            _new_level_data.special_probability += 0.1;
            _new_level_data.steel_probability += 0.1;
            _new_level_data.icon = "spr_block_steel";
            // _button._icon = spr_block_steel;
            break;
        case "More Rainbow":
            _new_level_data.rainbow_probability += 0.1;
            _new_level_data.icon = "spr_block_rainbow"; 
            // _button._icon = spr_block_rainbow;
            break;
        case "More Explosive":
            _new_level_data.explosive_probability += 0.1;
            _new_level_data.icon = "spr_block_explosive";
            // _button._icon = spr_block_explosive;
            break;
    }

    return _new_level_data;
}
