function src_update_progress() {
    var _stars = scr_calculate_stars();
    var _score = obj_game.score;
    for (var _i = 0; _i < array_length(global._game_state); _i++) {
        var _level_data = global._game_state[_i];
        if (_level_data.index == global._generated_level.level_data.index) {
            // Update stars if better
            var _current_stars = struct_get(_level_data, "stars") ?? 0;
            if (_stars > _current_stars) {
                _level_data.stars = _stars;
            }
            // Update high score if better
            var _current_score = struct_get(_level_data, "high_score") ?? 0;
            if (_score > _current_score) {
                _level_data.high_score = _score;
            }
            // Save back to file
            scr_save();
            break;
        }
    }
}