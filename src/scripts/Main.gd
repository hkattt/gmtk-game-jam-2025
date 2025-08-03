class_name Main extends Node2D

func _ready() -> void:
	LevelManager.completed.connect(_on_levels_complete, CONNECT_ONE_SHOT)
	LevelManager.start_next_level()
	
func _on_levels_complete() -> void:
	print("Levels done")
