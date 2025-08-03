extends Node2D

enum Sound {
	JUMP,
	EXIT,
	LOOP
}

@onready var sound_player: AudioStreamPlayer2D = $SoundPlayer

@onready var jump_sound: AudioStream = preload("res://assets/sfx/jump.mp3")
@onready var exit_sound: AudioStream = preload("res://assets/sfx/exit.mp3")
@onready var loop_sound: AudioStream = preload("res://assets/sfx/loop.mp3")

@onready var sounds: Dictionary = {
	Sound.JUMP: jump_sound,
	Sound.EXIT: exit_sound,
	Sound.LOOP: loop_sound
}

func play_sound(sound: Sound, volume_db: float = 0.0) -> void:
	if sound in sounds:
		var audio_stream: AudioStream = sounds[sound]
		
		if sound_player.stream == audio_stream:
			return
		
		sound_player.stop()
		sound_player.stream = audio_stream
		sound_player.set_volume_db(volume_db)
		sound_player.play()
		
func stop_sound():
	sound_player.stop()
