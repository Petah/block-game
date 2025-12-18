function scr_button_create(_x, _y, _width, _height, _text, _on_click) {
    var btn = {
        x: _x,
        y: _y,
        width: _width,
        height: _height,
        text: _text,
        on_click: _on_click
    };
    return btn;

}

function scr_button_step(_btn) {
    if (mouse_check_button_pressed(mb_left)) {
        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);
        if (_mx >= _btn.x && _mx <= _btn.x + _btn.width &&
            _my >= _btn.y && _my <= _btn.y + _btn.height) {
            // Clicked
            if (is_undefined(_btn.on_click) == false) {
                _btn.on_click();
            }
        }
    }
}

function scr_button_draw(_btn) {
    draw_sprite_stretched(spr_ui_button_grey, 0, _btn.x, _btn.y, _btn.width, _btn.height);
    scr_draw_text(_btn.x + _btn.width / 2, _btn.y + _btn.height / 2, _btn.text, {
        font: fnt_lg, color: c_gray, halign: fa_center, valign: fa_middle
    });
}
