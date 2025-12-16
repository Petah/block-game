// Collision with block - 'other' is the block we hit
var _block = other;

// Fireball passes through without physics bounce
if (self.fireball)
{
    // Cancel the physics collision response
    phy_position_x = xprevious;
    phy_position_y = yprevious;
}

// Steel blocks are indestructible
if (_block.block_type == "steel")
{
    // Just emit hit particles, no damage
    part_particles_create(obj_particles.part_sys, _block.x, _block.y, obj_particles.part_block_hit, 3);
    exit;
}

// Reduce block health
_block.health--;
obj_game.score += 10;

// Update sprite frame for normal blocks (color changes with health)
if (_block.block_type == "normal")
{
    if (_block.health <= 2) _block.image_index = 0;
    else if (_block.health <= 4) _block.image_index = 1;
    else if (_block.health <= 6) _block.image_index = 2;
    else if (_block.health <= 9) _block.image_index = 3;
    else if (_block.health <= 12) _block.image_index = 4;
    else if (_block.health <= 16) _block.image_index = 5;
    else _block.image_index = 6;
}

// Emit hit particles at block position
var _hit_part = self.fireball ? obj_particles.part_fire_destroy : obj_particles.part_block_hit;
var _hit_count = self.fireball ? 8 : 5;
part_particles_create(obj_particles.part_sys, _block.x, _block.y, _hit_part, _hit_count);

// Trigger split on next step (not during collision)
if (!self.will_split && !self.is_bonus)
{
    // Check if ball has split power-up (set elsewhere when collecting power-up)
}

if (_block.health <= 0)
{
    // Increment combo and reset timer
    obj_game.combo++;
    obj_game.combo_timer = obj_game.combo_timeout;

    // Screen shake scales with combo (bigger combos = more shake)
    var _shake = min(2 + obj_game.combo * 0.5, 8);

    // Explosive blocks destroy adjacent blocks
    if (_block.block_type == "explosive")
    {
        _shake = 6; // Big shake for explosion
        var _bx = _block.x;
        var _by = _block.y;
        var _cell = obj_game.grid_cell_size;

        // Check all 8 adjacent cells
        var _dirs = [
            [-_cell, -_cell], [0, -_cell], [_cell, -_cell],
            [-_cell, 0],                   [_cell, 0],
            [-_cell, _cell],  [0, _cell],  [_cell, _cell]
        ];

        for (var _d = 0; _d < 8; _d++)
        {
            var _adj = instance_position(_bx + _dirs[_d][0], _by + _dirs[_d][1], obj_block);
            if (_adj != noone && _adj.block_type != "steel")
            {
                // Destroy adjacent block
                obj_game.combo++;
                obj_game.score += 10;
                part_particles_create(obj_particles.part_sys, _adj.x, _adj.y, obj_particles.part_fire_destroy, 12);
                instance_destroy(_adj);
            }
        }
    }

    obj_screen_shake.shake_amount = max(obj_screen_shake.shake_amount, _shake);

    // Emit destroy particles before destroying
    var _destroy_part = self.fireball ? obj_particles.part_fire_destroy : obj_particles.part_block_destroy;
    var _destroy_count = self.fireball ? 25 : 15;
    if (_block.block_type == "explosive") _destroy_count = 30;
    part_particles_create(obj_particles.part_sys, _block.x, _block.y, _destroy_part, _destroy_count);

    instance_destroy(_block);
}
