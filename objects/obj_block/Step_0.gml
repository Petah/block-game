// Rainbow block health regeneration
if (self.block_type == "rainbow" && self.health < self.initial_health)
{
    self.regen_timer++;

    if (self.regen_timer >= self.regen_interval)
    {
        self.regen_timer = 0;
        self.health++;

        // Visual feedback - emit particles when healing
        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_powerup, 5);
    }
}
