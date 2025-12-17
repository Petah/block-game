/// @description Create physics wall fixture
// Wall dimensions set by spawner via wall_width and wall_height variables

// Default dimensions (will be overridden by spawner)
if (!variable_instance_exists(id, "wall_width")) self.wall_width = 32;
if (!variable_instance_exists(id, "wall_height")) self.wall_height = 32;

// Create physics fixture for wall
var _fix = physics_fixture_create();
physics_fixture_set_box_shape(_fix, self.wall_width / 2, self.wall_height / 2);
physics_fixture_set_restitution(_fix, 1.0); // Perfect bounce
physics_fixture_set_friction(_fix, 0.0);
physics_fixture_set_density(_fix, 0.0); // Static
physics_fixture_set_kinematic(_fix);
physics_fixture_bind(_fix, id);
physics_fixture_delete(_fix);
