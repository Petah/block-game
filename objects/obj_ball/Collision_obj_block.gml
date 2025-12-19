// Collision with block - 'other' is the block we hit
var _block = other;

// Play block hit sound
scr_block_sound(_block);

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
    scr_block_color(_block);
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

    // Explosive blocks push and damage nearby blocks using physics
    if (_block.block_type == "explosive")
    {
        _shake = 8; // Big shake for explosion
        var _bx = _block.x;
        var _by = _block.y;
        var _push_radius = obj_game.grid_cell_size * 3; // Affect blocks within 3 cells
        var _push_strength = 800; // Physics impulse strength

        // Find all blocks in radius and push them away
        with (obj_block)
        {
            if (id == _block.id) continue; // Skip self

            var _dist = point_distance(_bx, _by, x, y);
            if (_dist < _push_radius && _dist > 0)
            {
                // Calculate push direction (away from explosion)
                var _dir = point_direction(_bx, _by, x, y);
                var _falloff = 1 - (_dist / _push_radius); // Stronger push when closer
                var _force = _push_strength * _falloff;

                // Apply physics impulse
                var _ix = lengthdir_x(_force, _dir);
                var _iy = lengthdir_y(_force, _dir);
                physics_apply_impulse(x, y, _ix, _iy);

                // Damage non-steel blocks
                if (self.block_type != "steel")
                {
                    self.health--;
                    obj_game.score += 10;
                    obj_game.combo++;

                    // Emit hit particles
                    part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_fire_destroy, 8);

                    // Destroy if health depleted
                    if (self.health <= 0)
                    {
                        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_fire_destroy, 15);
                        instance_destroy();
                    }
                }
                else
                {
                    // Steel blocks still get pushed but not damaged
                    part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_block_hit, 5);
                }
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
