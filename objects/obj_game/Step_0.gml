// Don't process if game ended or level complete
if (self.level_complete || self.game_over) exit;

// Count balls currently in play
var _balls_in_flight = instance_number(obj_ball);

// === CHECK FOR LEVEL COMPLETE (every frame) ===
var _non_steel_count = 0;
with (obj_block) {
    if (block_type != "steel") _non_steel_count++;
}

if (_non_steel_count == 0)
{
    // Level complete!
    self.level_complete = true;

    // Explode all balls like fireworks
    with (obj_ball)
    {
        // Create firework explosion at ball position
        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_firework, 25);
        part_particles_create(obj_particles.part_sys, x, y, obj_particles.part_firework_spark, 40);
        instance_destroy();
    }

    // Big screen shake for celebration
    obj_screen_shake.shake_amount = 10;

    // Clear any remaining steel blocks
    with (obj_block) { instance_destroy(); }

    // Calculate and save stars
    self.stars_earned = scr_complete_level(self.level, self.turns);

    // Show level complete overlay
    instance_create_layer(0, 0, "instances", obj_level_complete);
    exit;
}

// === SLINGSHOT AIMING (allowed in playing or waiting states) ===
if (self.state == "playing" || self.state == "waiting")
{
    // Start drag when clicking in the launch area (danger zone / bottom area)
    if (mouse_check_button_pressed(mb_left) && !self.is_dragging)
    {
        // Only start drag if we have balls and click is in lower portion of screen
        if (self.balls_available > 0 && mouse_y > self.grid_bottom_y)
        {
            self.is_dragging = true;
            self.drag_start_x = mouse_x;
            self.drag_start_y = mouse_y;
        }
    }

    // Update aim while dragging
    if (self.is_dragging)
    {
        // Calculate pull vector (from current mouse to drag start = direction ball will go)
        var _dx = self.drag_start_x - mouse_x;
        var _dy = self.drag_start_y - mouse_y;
        var _pull_dist = point_distance(0, 0, _dx, _dy);

        // Calculate aim angle (opposite of drag direction)
        if (_pull_dist > 10)
        {
            self.aim_angle = point_direction(0, 0, _dx, _dy);
            // Clamp to upward angles only (between 20 and 160 degrees)
            self.aim_angle = clamp(self.aim_angle, 20, 160);
        }

        // Calculate pull strength (0 to 1)
        self.pull_strength = clamp(_pull_dist / self.max_pull_distance, 0, 1);

        // Update launch position to drag start point
        self.launch_x = clamp(self.drag_start_x, 50, room_width - 50);
        self.launch_y = clamp(self.drag_start_y, self.grid_bottom_y + 30, room_height - 30);
    }

    // Fire on release - start burst firing all available balls
    if (mouse_check_button_released(mb_left) && self.is_dragging)
    {
        self.is_dragging = false;

        // Only fire if pulled back enough
        if (self.pull_strength > 0.1)
        {
            // Lock in firing parameters
            self.balls_to_fire = self.balls_available;
            self.fire_delay = 0;
            self.turns++; // Count as one turn

            // Calculate and lock fire speed
            var _base_speed = 800;
            if (instance_exists(obj_debug))
            {
                _base_speed *= obj_debug.speed_multiplier;
            }
            self.fire_speed = _base_speed * self.pull_strength;

            // Switch to firing state
            self.state = "firing";
        }

        // Reset pull strength
        self.pull_strength = 0;
    }

    // Cancel drag on right click
    if (mouse_check_button_pressed(mb_right) && self.is_dragging)
    {
        self.is_dragging = false;
        self.pull_strength = 0;
    }
}

// === BURST FIRING ===
if (self.state == "firing")
{
    self.fire_delay--;

    if (self.fire_delay <= 0 && self.balls_to_fire > 0 && self.balls_available > 0)
    {
        // Create and fire a ball
        var _ball = instance_create_layer(self.launch_x, self.launch_y, "instances", obj_ball);
        _ball.ball_speed = self.fire_speed;

        // Apply physics impulse in the aim direction
        var _impulse_x = lengthdir_x(self.fire_speed, self.aim_angle);
        var _impulse_y = lengthdir_y(self.fire_speed, self.aim_angle);
        with (_ball) {
            physics_apply_impulse(x, y, _impulse_x, _impulse_y);
        }

        // Use a ball
        self.balls_available--;
        self.balls_to_fire--;
        self.fire_delay = self.fire_interval;
    }

    // Switch to waiting once all balls fired
    if (self.balls_to_fire <= 0 || self.balls_available <= 0)
    {
        self.state = "waiting";
    }
}

// === WAITING FOR BALLS TO RETURN ===
if (self.state == "waiting")
{
    // Turn ends when all balls have returned (none in flight, all available)
    if (_balls_in_flight == 0 && self.balls_available >= self.num_balls && !self.is_dragging)
    {
        // Reset bonus balls for next turn
        self.bonus_balls = 0;

        // Reset combo at turn end
        self.combo = 0;

        // Back to playing
        self.state = "playing";
    }
}

// Update combo timer
if (self.combo_timer > 0)
{
    self.combo_timer--;
    if (self.combo_timer <= 0)
    {
        self.combo = 0;
    }
}
