function scr_button_create(_buttons, _x, _y, _width, _height, _text, _on_click, _on_draw) {
    scr_button_create_ext(_buttons, {
        x: _x,
        y: _y,
        width: _width,
        height: _height,
        text: _text,
        on_click: _on_click,
        on_draw: _on_draw,
    });
}

function scr_button_create_ext(_buttons, _options) {
    var _btn = {
        x: _options[$ "x"],
        y: _options[$ "y"],
        width: _options[$ "width"],
        height: _options[$ "height"],
        text: _options[$ "text"] ?? false,
        on_click: _options[$ "on_click"],
        on_draw: _options[$ "on_draw"] ?? false,
        sprite: _options[$ "sprite"] ?? spr_ui_button_grey,
        icon: _options[$ "icon"] ?? noone,
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
        draw_sprite_stretched(_btn.sprite, 0, _btn.x, _btn.y, _btn.width, _btn.height);
        if (_btn.text) {
            scr_draw_text(_btn.x + _btn.width / 2, _btn.y + _btn.height / 2, _btn.text, {
                font: fnt_lg, color: c_gray, halign: fa_center, valign: fa_middle
            });
        }
        if (_btn.icon != noone) {
            var _icon_x = _btn.x + _btn.width / 2;
            var _icon_y = _btn.y + _btn.height / 2;
            var _icon_scale = 1;
            draw_sprite_ext(_btn.icon, 0, _icon_x, _icon_y, _icon_scale, _icon_scale, 0, c_white, 1);
        }
        if (_btn.on_draw) {
            _btn.on_draw(_btn);
        }
    }
}
