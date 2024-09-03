extends Node

@onready var place_flag_audio_stream_player = $PlaceFlagAudioStreamPlayer
@onready var explosion_audio_stream_player = $ExplosionAudioStreamPlayer
@onready var win_game_audio_stream_player = $WinGameAudioStreamPlayer
	
func play_flag_sound():
	place_flag_audio_stream_player.play()
	
func play_explosion_sound():
	explosion_audio_stream_player.play()
	
func play_win_game_sound():
	win_game_audio_stream_player.play()
