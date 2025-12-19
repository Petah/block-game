// === PLAYING STATE - INSTRUCTIONS ===
var _text_y = obj_danger_zone.y - 50;
if (self.state == "playing" && !self.is_dragging && self.balls_available > 0)
{
    scr_draw_text(room_width / 2, _text_y, "Drag back to aim, release to fire", {
        font: fnt_sm, color: c_white, halign: fa_center, alpha: 0.7
    });
}

// === FIRING/WAITING STATE - BOTTOM UI ===
if (self.state == "firing" || self.state == "waiting")
{
    var _in_play = instance_number(obj_ball);
    scr_draw_text(room_width / 2, _text_y, "Balls in play: " + string(_in_play), {
        font: fnt_sm, color: c_white, halign: fa_center, alpha: 0.7
    });
}
