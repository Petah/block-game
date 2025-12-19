function scr_init_game() {
    if (variable_global_exists("_initialized")) {
        instance_create_layer(0, 0, "ui", obj_main_menu);
        return;
    }
    global._initialized = true;
    global._header_height = 90; 
    global._danger_zone_size = 300; 
    global._level_spacing = 120;
    global._game_area = {
        x: 0,
        y: global._header_height,
        width: room_width,
        height: room_height - global._header_height - global._danger_zone_size
    };
    instance_create_layer(0, 0, "ui", obj_main_menu);
}