function scr_draw_button(_x, _y, _width, _height, _text) {
    draw_sprite_stretched(spr_ui_button_grey, 0, _x, _y, _width, _height);
    scr_draw_text(_x + _width / 2, _y + _height / 2, _text, {
        font: fnt_lg, color: c_gray, halign: fa_center, valign: fa_middle
    });
}