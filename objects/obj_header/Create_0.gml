self._buttons = [];

// Back button to main menu
scr_button_create_ext(self._buttons, {
    x: 10, 
    y: 10, 
    width: 70, 
    height: 70,
    sprite: spr_ui_button_grey_thin,
    icon: spr_back,
    on_click: function() {
        room_goto(rm_main_menu);
    },
});