if (lerping_to_punch) {
    current_scale = lerp(current_scale, punch_scale, lerp_speed);
    if (current_scale <= punch_scale + 0.05) {
        lerping_to_punch = false;
    }
} else {
    current_scale = lerp(current_scale, original_scale, lerp_speed);
}

// Update the scale of the glove
image_xscale = current_scale;
image_yscale = current_scale;