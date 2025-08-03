class_name Main extends Node2D

@onready var screen_transition: ScreenTransition = $ScreenTransition

func _ready() -> void:
	MusicManager.play_music(MusicManager.Music.PIANO, -10.0)
	SceneManager.start_game(screen_transition)	
