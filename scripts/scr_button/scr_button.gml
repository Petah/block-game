function scr_button_create(_buttons, _x, _y, _width, _height, _text, _on_click, _on_draw) {
    var _btn = {
        x: _x,
        y: _y,
        width: _width,
        height: _height,
        text: _text,
        on_click: _on_click,
        on_draw: _on_draw,
    };
    array_push(_buttons, _btn);
}

function scr_button_step(_buttons) {
    for (var _i = 0; _i < array_length(_buttons); _i++) {
        var _btn = _buttons[_i];
        if (mouse_check_button_pressed(mb_left)) {
            var _mx = device_mouse_x_to_gui(0);
            var _my = device_mouse_y_to_gui(0);
            if (_mx >= _btn.x && _mx <= _btn.x + _btn.width &&
                _my >= _btn.y && _my <= _btn.y + _btn.height) {
                // Clicked
                if (_btn.on_click) {
                    _btn.on_click();
                }
            }
        }
    }
}

function scr_button_draw(_buttons) {
    for (var _i = 0; _i < array_length(_buttons); _i++) {
        var _btn = _buttons[_i];
        draw_sprite_stretched(spr_ui_button_grey, 0, _btn.x, _btn.y, _btn.width, _btn.height);
        scr_draw_text(_btn.x + _btn.width / 2, _btn.y + _btn.height / 2, _btn.text, {
            font: fnt_lg, color: c_gray, halign: fa_center, valign: fa_middle
        });
        if (_btn.on_draw) {
            _btn.on_draw(_btn);
        }
    }
}
