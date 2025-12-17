function scr_create_wall(_x, _y, _width, _height) {
    var _wall = instance_create_layer(_x + _width / 2, _y + _height / 2, "instances", obj_wall);
    var _fix = physics_fixture_create();
    physics_fixture_set_box_shape(_fix, _width / 2, _height / 2);
    physics_fixture_set_collision_group(_fix, 1);
    physics_fixture_set_kinematic(_fix);
    physics_fixture_bind(_fix, _wall);
    physics_fixture_delete(_fix);
}
