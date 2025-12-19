function scr_block_color(_block) {
    // Set sprite frame based on health (7 color tiers)
    var _frames = sprite_get_number(_block.sprite_index);
    _block.image_index = min(floor(((_block.health - 1) / global._generated_level.level_data.max_health) * _frames), _frames - 1);
}