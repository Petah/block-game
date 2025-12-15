// Draw behind other objects
depth = 1000;

// Create Play button
var _btn = instance_create_layer(room_width / 2, room_height / 2 + 100, "Instances", obj_button);
_btn.text = "PLAY";
_btn.width = 240;
_btn.height = 70;
_btn.on_click = function() {
    room_goto(rm_game);
};
