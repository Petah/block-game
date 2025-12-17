/// @function scr_spawn_block(_x, _y, _type)
/// @description Creates a block at the specified position with the given type
/// @param {Real} _x - X position (center of block)
/// @param {Real} _y - Y position (center of block)
/// @param {Real|String} _type - Block type: number for normal block health, "e" for explosive, "s" for steel, "r" for rainbow
/// @returns {Id.Instance} The created block instance

function scr_spawn_block(_x, _y, _type) {
    var _block = instance_create_layer(_x, _y, "instances", obj_block);

    // Don't animate - frame is set based on type/health
    _block.image_speed = 0;

    // Handle different block types
    if (is_string(_type)) {
        switch (_type) {
            case "e":
            case "explosive":
                _block.block_type = "explosive";
                _block.health = 2;
                _block.sprite_index = spr_block_explosive;
                _block.image_index = 0;
                break;
            case "s":
            case "steel":
                _block.block_type = "steel";
                _block.health = 999;
                _block.sprite_index = spr_block_steel;
                _block.image_index = 0;
                break;
            case "r":
            case "rainbow":
                _block.block_type = "rainbow";
                _block.health = 3;
                _block.initial_health = 3;
                _block.sprite_index = spr_block_rainbow;
                _block.image_index = 0;
                break;
            default:
                // Unknown string type, treat as normal with health 1
                _block.block_type = "normal";
                _block.health = 1;
                _block.sprite_index = spr_block;
                _block.image_index = 0;
                break;
        }
    } else {
        // Numeric type = normal block with that health value
        _block.block_type = "normal";
        _block.health = max(1, _type);
        _block.sprite_index = spr_block;

        // Set sprite frame based on health (7 color tiers)
        if (_block.health <= 2) _block.image_index = 0;       // Blue
        else if (_block.health <= 4) _block.image_index = 1;  // Green
        else if (_block.health <= 6) _block.image_index = 2;  // Yellow
        else if (_block.health <= 9) _block.image_index = 3;  // Orange
        else if (_block.health <= 12) _block.image_index = 4; // Red
        else if (_block.health <= 16) _block.image_index = 5; // Purple
        else _block.image_index = 6;                          // Pink
    }

    // Scale block to fit grid cell size
    _block.image_xscale = obj_game.grid_cell_size / _block.sprite_width;
    _block.image_yscale = obj_game.grid_cell_size / _block.sprite_height;

    // Set home position for spring-back effect
    _block.home_x = _x;
    _block.home_y = _y;

    // Create physics fixture to match scaled size
    with (_block) {
        // Create new fixture matching the scaled size
        var _fix = physics_fixture_create();
        var _half_size = obj_game.grid_cell_size / 2 - 2;
        physics_fixture_set_box_shape(_fix, _half_size, _half_size);
        physics_fixture_set_restitution(_fix, 0.5); // Less bouncy so ball doesn't lose energy
        //physics_fixture_set_friction(_fix, 1.0);
        physics_fixture_set_linear_damping(_fix, 1.0);
        physics_fixture_set_angular_damping(_fix, 1.0);
        physics_fixture_set_collision_group(_fix, 1);
        physics_fixture_set_density(_fix, 1.0);
        physics_fixture_bind(_fix, id);
        physics_fixture_delete(_fix);
    }

    return _block;
}
