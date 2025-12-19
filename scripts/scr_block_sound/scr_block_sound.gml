/// @description Play block hit sound based on block health
/// @param {Id.Instance} _block - The block instance that was hit
function scr_block_sound(_block) {
    var _sounds = [
        snd_impact_wood_light_000,
        snd_impact_wood_light_001,
        snd_impact_wood_light_002,
        snd_impact_wood_light_003,
        snd_impact_wood_light_004,
    ];
    var _sound = _sounds[clamp(floor(((_block.health - 1) / global._generated_level.level_data.max_health) * array_length(_sounds)), 0, array_length(_sounds) - 1)];
    audio_play_sound(_sound, 0, false);
}