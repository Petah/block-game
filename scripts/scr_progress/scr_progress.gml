// Global progress tracking with persistence
// Call scr_init_progress() at game start

function scr_init_progress() {
    // Initialize if not already done
    if (!variable_global_exists("progress_initialized")) {
        global.progress_initialized = true;
        global.levels_unlocked = 1;
        global.level_stars = array_create(100, 0); // Stars for each level (0-3)
        global.selected_level = 1;
        global.high_score = 0;

        // Load saved progress
        scr_load_progress();
    }
}

function scr_save_progress() {
    ini_open("save.ini");

    // Save basic progress
    ini_write_real("progress", "levels_unlocked", global.levels_unlocked);
    ini_write_real("progress", "high_score", global.high_score);

    // Save stars as comma-separated string
    var _stars_str = "";
    for (var i = 0; i < array_length(global.level_stars); i++) {
        _stars_str += string(global.level_stars[i]);
        if (i < array_length(global.level_stars) - 1) _stars_str += ",";
    }
    ini_write_string("progress", "level_stars", _stars_str);

    ini_close();
}

function scr_load_progress() {
    if (!file_exists("save.ini")) return;

    ini_open("save.ini");

    // Load basic progress
    global.levels_unlocked = ini_read_real("progress", "levels_unlocked", 1);
    global.high_score = ini_read_real("progress", "high_score", 0);

    // Load stars from comma-separated string
    var _stars_str = ini_read_string("progress", "level_stars", "");
    if (_stars_str != "") {
        var _stars_arr = string_split(_stars_str, ",");
        for (var i = 0; i < array_length(_stars_arr); i++) {
            if (i < array_length(global.level_stars)) {
                global.level_stars[i] = real(_stars_arr[i]);
            }
        }
    }

    ini_close();
}

function scr_get_level_stars(_level) {
    scr_init_progress();
    if (_level < 1 || _level > array_length(global.level_stars)) return 0;
    return global.level_stars[_level - 1];
}

function scr_set_level_stars(_level, _stars) {
    scr_init_progress();
    if (_level < 1 || _level > array_length(global.level_stars)) return;
    // Only update if better than previous
    if (_stars > global.level_stars[_level - 1]) {
        global.level_stars[_level - 1] = _stars;
        scr_save_progress();
    }
}

function scr_is_level_unlocked(_level) {
    scr_init_progress();
    return _level <= global.levels_unlocked;
}

function scr_unlock_level(_level) {
    scr_init_progress();
    if (_level > global.levels_unlocked) {
        global.levels_unlocked = _level;
        scr_save_progress();
    }
}

function scr_update_high_score(_score) {
    scr_init_progress();
    if (_score > global.high_score) {
        global.high_score = _score;
        scr_save_progress();
    }
}

function scr_get_high_score() {
    scr_init_progress();
    return global.high_score;
}

function scr_complete_level(_level, _turns) {
    scr_init_progress();

    // Get level data for par calculation
    var _level_data = scr_get_level_data(_level);
    var _par = 3; // Default par

    // Calculate par based on layout size
    if (_level_data.layout != undefined) {
        var _rows = array_length(_level_data.layout);
        var _cols = array_length(_level_data.layout[0]);
        var _block_count = 0;
        for (var r = 0; r < _rows; r++) {
            for (var c = 0; c < _cols; c++) {
                if (_level_data.layout[r][c] != 0) _block_count++;
            }
        }
        // Par is roughly blocks / (balls * 3)
        _par = max(2, ceil(_block_count / (_level_data.balls * 2)));
    }

    // Calculate stars based on turns vs par
    var _stars = 1; // Minimum 1 star for completing
    if (_turns <= _par) {
        _stars = 3;
    } else if (_turns <= _par * 2) {
        _stars = 2;
    }

    // Save stars and unlock next level
    scr_set_level_stars(_level, _stars);
    scr_unlock_level(_level + 1);

    return _stars;
}

function scr_reset_progress() {
    global.levels_unlocked = 1;
    global.level_stars = array_create(100, 0);
    global.high_score = 0;
    scr_save_progress();
}
