// Test room - spawn one of each power-up type
var _y = 400;
var _spacing = 80;
var _start_x = (room_width - (_spacing * 3)) / 2;

// Type 0: Extra ball
var _p0 = instance_create_layer(_start_x, _y, "Instances", obj_power_up);
_p0.type = 0;
_p0.image_index = 0;

// Type 1: Fireball
var _p1 = instance_create_layer(_start_x + _spacing, _y, "Instances", obj_power_up);
_p1.type = 1;
_p1.image_index = 1;

// Type 2: Split
var _p2 = instance_create_layer(_start_x + _spacing * 2, _y, "Instances", obj_power_up);
_p2.type = 2;
_p2.image_index = 2;

// Type 3: Big ball
var _p3 = instance_create_layer(_start_x + _spacing * 3, _y, "Instances", obj_power_up);
_p3.type = 3;
_p3.image_index = 3;

// Add a few blocks to test power-ups on
for (var i = 0; i < 5; i++)
{
    var _block = instance_create_layer(144 + i * 96, 250, "Instances", obj_block);
    _block.health = 3;
}
