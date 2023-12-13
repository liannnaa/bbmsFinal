// Initialize variables
speedData = -1;
roomSwitchDelay = 60 *  2;

playerHealth = 20;
enemyHealth = 20;

hp_max = 20;
flash = 0;
healthbar_width = 170;
healthbar_height = 20;

flashOpacity = 0; // Opacity of the flash effect
flashColor = c_white; // Color of the flash effect
shakeDuration = 0; // Duration of the screen shake
shakeIntensity = 4; // Intensity of the screen shake

alarm[0] = -1;

global.isBlocking = false;

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
	speedData = newSpeedData;
} else {
	show_debug_message("Failed to open file.");
}