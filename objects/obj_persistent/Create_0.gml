persistent = true;

if (!audio_is_playing(snd_bg)) {
    audio_play_sound(snd_bg, 1, true); // 1 is the priority, true is for looping
}