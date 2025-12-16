/// @function scr_draw_pill(_x, _y, _text, [_options])
/// @description Draws a pill with centered text using 9-slice sprite
/// @param {Real} _x - X position (left edge)
/// @param {Real} _y - Y position (top edge)
/// @param {String} _text - Text to display
/// @param {Struct} [_options] - Optional struct with: font, color, padding, alpha

function scr_draw_pill(_x, _y, _text, _options = {}) {
    var _font = _options[$ "font"] ?? fnt_sm;
    var _color = _options[$ "color"] ?? c_white;
    var _padding = _options[$ "padding"] ?? 20;
    var _alpha = _options[$ "alpha"] ?? 0.8;

    // Calculate pill dimensions based on text
    draw_set_font(_font);
    var _text_w = string_width(_text);
    var _text_h = string_height(_text);

    var _pill_w = _text_w + _padding * 2;
    var _pill_h = sprite_get_height(spr_pill) / 2; // Assuming 2x sprite

    // Draw 9-slice pill background
    draw_sprite_stretched_ext(spr_pill, 0, _x, _y, _pill_w, _pill_h, c_white, _alpha);

    // Draw centered text
    scr_draw_text(_x + _pill_w / 2, _y + _pill_h / 2 - 2, _text, {
        font: _font,
        color: _color,
        halign: fa_center,
        valign: fa_middle
    });
}
