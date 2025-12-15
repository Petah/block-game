// Update screen shake
if (self.shake_amount > 0)
{
    self.shake_x = random_range(-self.shake_amount, self.shake_amount);
    self.shake_y = random_range(-self.shake_amount, self.shake_amount);
    self.shake_amount *= 0.85; // Decay

    if (self.shake_amount < 0.5)
    {
        self.shake_amount = 0;
        self.shake_x = 0;
        self.shake_y = 0;
    }
}

// Apply shake to camera
camera_set_view_pos(self.cam, self.shake_x, self.shake_y);
