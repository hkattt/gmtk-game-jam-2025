class_name Main extends Node2D

func _ready() -> void:
	MusicManager.play_music(MusicManager.Music.PIANO, -10.0)
	LevelManager.completed.connect(_on_levels_complete, CONNECT_ONE_SHOT)
	LevelManager.start_next_level()
	
func _on_levels_complete() -> void:
	print("Levels done")
