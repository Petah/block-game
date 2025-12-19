function scr_calculate_stars() {
    var _par = 3; // Default par

    // Calculate par based on layout size
    var _rows = array_length(global._generated_level.layout);
    var _cols = array_length(global._generated_level.layout[0]);
    var _block_count = 0;
    for (var r = 0; r < _rows; r++) {
        for (var c = 0; c < _cols; c++) {
            if (global._generated_level.layout[r][c] != 0) _block_count++;
        }
    }
    // Par is roughly blocks / (balls * 3)
    _par = max(2, ceil(_block_count / (global._generated_level.balls * 2)));

    // Calculate stars based on turns vs par
    var _stars = 1; // Minimum 1 star for completing
    if (obj_game._turns <= _par) {
        _stars = 3;
    } else if (obj_game._turns <= _par * 2) {
        _stars = 2;
    }

    return _stars;
}