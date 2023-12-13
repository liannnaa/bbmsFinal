if(room == rm_game){
	draw_sprite(spr_back, 0, 30, 30);
	draw_sprite_stretched(spr_health, 0, 30, 30, (enemyHealth/hp_max) * healthbar_width, healthbar_height);	
	draw_sprite(spr_bar, 0, 30, 30);

	draw_text_color(30, 5, "Enemy Health", c_black, c_black, c_black, c_black, 1);


	draw_sprite(spr_back, 0, room_width-192- 30, 30);
	draw_sprite_stretched(spr_health, 0, room_width-192- 30, 30, (playerHealth/hp_max) * healthbar_width, healthbar_height);	
	draw_sprite(spr_bar, 0, room_width-192- 30, 30);
	
	draw_text_color(room_width-192- 30, 5, "Player Health", c_black, c_black, c_black, c_black, 1);
}