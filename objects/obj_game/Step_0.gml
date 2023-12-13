if(room == rm_game){
	
	// PLAYER
	var userDirectory = "/Users/liannapoblete/Documents/code/bbmsFinal";
	var filePath = userDirectory + "/speed_data.txt";
	var file = file_text_open_read(filePath);

	if (file != -1) {
		var newSpeedData = "";
		while (!file_text_eof(file)) {
		    var load_file = file_text_readln(file);
		    newSpeedData += load_file;
		}
		file_text_close(file);

		newSpeedData = string_trim(newSpeedData);
		
		if (newSpeedData == "") {
			newSpeedData = "0"; // Set to "0" if it's empty
		} else if(real(newSpeedData) > 15){
			newSpeedData = "15";
		}

		// Check if the data is different from previous data
		if (newSpeedData != speedData) {
			show_debug_message("New Speed Data: " + newSpeedData);
			speedData = newSpeedData;
			
			var punchSpeed = real(speedData);

			// Apply punch effect
			if (instance_exists(obj_enemy)) {
				obj_playerGlove.lerping_to_punch = true;
			    enemyHealth -= punchSpeed; // Player punches enemy
				flashOpacity = min(1, punchSpeed / 10); // Calculate opacity based on punch strength
				flashColor = c_white; // Set flash color to white for player punch
				audio_play_sound(snd_player_punch, 1, false);
				if(punchSpeed >= 5){
					audio_play_sound(snd_grunt, 1, false);
				}
				if(enemyHealth <= 0){
					room_goto(rm_win);
					audio_play_sound(snd_cheer, 1, false);
				}
			}
		}
	} else {
		show_debug_message("Failed to open file.");
	}
	
	// COMPUTER
	if (!alarm[0]) { // if alarm[0] is not already set
	    alarm[0] = irandom_range(30, 90); // set alarm[0] to a random value between 1-3 seconds (assuming 30 steps per second)
	}
} else {
	if (roomSwitchDelay > 0) {
		roomSwitchDelay--;
	} else {
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
		
			if(blockData == "Blocking"){
				if(room != rm_start){
					audio_play_sound(snd_bell, 1, false);
					room_goto(rm_game);
				} else {
					room_goto(rm_video);
				}
			}
		
		} else {
			show_debug_message("Failed to open file.");
		}
	}
}