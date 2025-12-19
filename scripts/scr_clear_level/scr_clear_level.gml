function scr_clear_level() {
    // Explode all balls/blocks like fireworks
    with (obj_ball)
    {
        // Create firework explosion at ball position
        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_firework, 25);
        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_firework_spark, 40);
        instance_destroy();
    }

    with (obj_block)
    {
        // Create firework explosion at block position
        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_firework, 25);
        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_firework_spark, 40);
        instance_destroy();
    }

    // Big screen shake for celebration
    obj_screen_shake.shake_amount = 10;
}