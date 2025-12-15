// Clean up particle system
part_type_destroy(self.part_block_hit);
part_type_destroy(self.part_block_destroy);
part_type_destroy(self.part_powerup);
part_type_destroy(self.part_ball_trail);
part_system_destroy(self.part_sys);

// Clean up camera
camera_destroy(self.cam);
