function scr_level_generator(_level_data) {
    var _min_width = _level_data.min_width;
    var _max_width = _level_data.max_width;
    var _min_health = _level_data.min_health;
    var _max_health = _level_data.max_health;
    var _min_balls = _level_data.min_balls;
    var _max_balls = _level_data.max_balls;
    var _special_probability = _level_data.special_probability;
    var _steel_probability = _level_data.steel_probability;
    var _rainbow_probability = _level_data.rainbow_probability;
    var _explosive_probability = _level_data.explosive_probability;

    random_set_seed(_level_data.seed);

    var _generated_level = {
        level_data: _level_data,
        balls: irandom_range(_min_balls, _max_balls),
        layout: [],
    }
    

    var _width = irandom_range(_min_width, _max_width);
    var _block_size = global._game_area.width / _width;
    var _min_height = min(floor(global._game_area.height / _block_size), _level_data.min_height);
    var _max_height = min(floor(global._game_area.height / _block_size), _level_data.max_height);
    var _min_diff = _level_data.min_height - _min_height;
    var _max_diff = _level_data.max_height - _max_height;
    // Adjust width if there is not enough height to fit blocks
    _min_width += _min_diff; 
    _max_width += _max_diff; 
    _width = irandom_range(_min_width, _max_width);
    _block_size = global._game_area.width / _width;
    var _height = irandom_range(_min_height, _max_height);
    var _types = [
        "steel",
        "rainbow",
        "explosive",
    ];
    for (var _y = 0; _y < _height; _y++) {
        var _row = [];
        for (var _x = 0; _x < _width; _x++) {
            var _block = irandom_range(_min_health, _max_health)
            var _special = random(1) <= _special_probability ? true : false;
            if (_special) {
                var _chance = random(1);
                var _type = _types[irandom_range(0, array_length(_types) - 1)];
                switch (_type) {
                    case "steel":
                        if (_chance <= _steel_probability) {
                            _block = "s";
                        }
                        break;
                    case "rainbow":
                        if (_chance <= _rainbow_probability) {
                            _block = "r";
                        }
                        break;
                    case "explosive":
                        if (_chance <= _explosive_probability) {
                            _block = "e";
                        }
                        break;
                }
            }
            array_push(_row, _block);
        }
        array_push(_generated_level.layout, _row);
    }

    return _generated_level;
}