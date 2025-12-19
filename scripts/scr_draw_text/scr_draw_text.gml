/// @function scr_draw_text(_x, _y, _text, [_options])
/// @description Draw text with options for font, color, alignment, and alpha
/// @param {Real} _x - X position
/// @param {Real} _y - Y position
/// @param {String} _text - Text to draw
/// @param {Struct} [_options] - Optional struct with: font, color, halign, valign, alpha, shadow
function scr_draw_text(_x, _y, _text, _options = {}) {
    // Store current settings
    var _prev_font = draw_get_font();
    var _prev_color = draw_get_color();
    var _prev_halign = draw_get_halign();
    var _prev_valign = draw_get_valign();
    var _prev_alpha = draw_get_alpha();

    // Apply options
    if (_options[$ "font"]) {
        draw_set_font(_options.font);
    }
    if (_options[$ "halign"]) {
        draw_set_halign(_options.halign);
    }
    if (_options[$ "valign"]) {
        draw_set_valign(_options.valign);
    }

    if (_options[$ "shadow"]) {
        // Draw shadow
        draw_set_color(c_black);
        draw_set_alpha(0.8);
        draw_text(_x + _options.shadow, _y + _options.shadow, _text);
    }

    if (_options[$ "color"]) {
        draw_set_color(_options.color);
    }
    
    // Draw the text
    draw_set_alpha(1);
    draw_text(_x, _y, _text);

    // Restore previous settings
    draw_set_font(_prev_font);
    draw_set_color(_prev_color);
    draw_set_halign(_prev_halign);
    draw_set_valign(_prev_valign);
    draw_set_alpha(_prev_alpha);
}
