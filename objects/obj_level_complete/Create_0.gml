self._panel_w = 400;
self._panel_h = 350;
self._panel_x = room_width / 2 - _panel_w / 2;
self._panel_y = room_height / 2 - _panel_h / 2;
self._pad = 16;
self._buttons = [];

var _children = scr_button_level_create(global._generated_level.level_data);
var _button_offset_y = 200;
for (var _i = 0; _i < array_length(_children); _i++) {
    scr_button_create(self._buttons, self._panel_x + self._pad, self._panel_y + _button_offset_y, self._panel_w - 2 * self._pad, 62, _children[_i].enhancement + " +", method({ 
        _level_data: _children[_i],
    }, function() {
        global._generated_level = scr_level_generator(_level_data);
        room_goto(rm_game);
    }), method({ 
        _icon: asset_get_index(_children[_i].icon), 
    }, function(_btn) {
        var _size = 32;
        draw_set_font(fnt_lg);
        var _xscale = _size / sprite_get_width(_icon);
        var _yscale = _size / sprite_get_height(_icon);
        var _x = _btn.x + _btn.width / 2 + string_width(_btn.text) / 2 + sprite_get_width(_icon) * _xscale / 2;
        var _y = _btn.y + _btn.height / 2;
        draw_sprite_ext(_icon, 0, _x, _y, _xscale, _yscale, 0, c_white, 1);
    }));
    _button_offset_y += self._pad / 2 + sprite_get_height(spr_ui_button_grey);
}
scr_save();

scr_button_create(self._buttons, self._panel_x + self._pad, self._panel_y + _button_offset_y, self._panel_w - 2 * self._pad, 62, "BACK", function() {
    room_goto(rm_main_menu);
});

self._panel_h = _button_offset_y + self._pad + sprite_get_height(spr_ui_button_grey);
