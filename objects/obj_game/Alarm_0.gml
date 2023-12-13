if (alarm[0] <= 0) {
	var enemyPunchSpeed = irandom(10); // Random punch speed
	obj_enemyGlove.lerping_to_punch = true;
	
	var userDirectory = "/Users/liannapoblete/Documents/code/bbmsFinal";
	var filePath = userDirectory + "/block_data.txt";
	var file = file_text_open_read(filePath);

	if (file != -1) {
		var blockData = "";
		while (!file_text_eof(file)) {
			var load_file = file_text_readln(file);
			blockData += load_file;
		}
		file_text_close(file);

		blockData = string_trim(blockData);
		
		if(blockData != "Blocking"){
			playerHealth -= enemyPunchSpeed; // Enemy punches player
			flashOpacity = min(1, enemyPunchSpeed / 10); // Calculate opacity based on punch strength
			flashColor = c_red; // Set flash color to red for computer punch
			shakeDuration = max(15, enemyPunchSpeed * 2); // Stronger shake for stronger punch
			audio_play_sound(snd_enemy_punch, 1, false);
			if(playerHealth <= 0){
			    room_goto(rm_lose);
				audio_play_sound(snd_boo, 1, false);
			}
		}
		
	} else {
		show_debug_message("Failed to open file.");
	}
	
	alarm[0] = irandom_range(30, 90); // Reset the alarm for another random interval
}