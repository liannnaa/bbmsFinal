// Flash Effect
if (flashOpacity > 0) {
    draw_set_color(flashColor);
    draw_set_alpha(flashOpacity); // Use the dynamic opacity
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1); // Reset alpha to 1
    flashOpacity -= 0.05; // Gradually reduce opacity; adjust as needed
    if (flashOpacity < 0) {
        flashOpacity = 0; // Ensure opacity doesn't go negative
    }
}

// Screen Shake Effect
if (shakeDuration > 0) {
    var shakeX = irandom_range(-shakeIntensity, shakeIntensity);
    var shakeY = irandom_range(-shakeIntensity, shakeIntensity);
    camera_set_view_pos(view_camera[0], view_xview[0] + shakeX, view_yview[0] + shakeY);
    shakeDuration--;
} else {
    // Reset to the normal camera position if shaking is over
    camera_set_view_pos(view_camera[0], view_xview[0], view_yview[0]);
}