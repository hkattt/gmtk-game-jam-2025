extends Node

signal completed

const LEVELS: Array[PackedScene] = [
	preload("res://scenes/levels/stage1/Level1.tscn"),
	preload("res://scenes/levels/stage1/Level2.tscn"),
	preload("res://scenes/levels/stage1/Level3.tscn"),
	preload("res://scenes/levels/stage2/Level1.tscn"),
	preload("res://scenes/levels/stage2/Level2.tscn"),
	preload("res://scenes/levels/stage2/Level3.tscn"),
	preload("res://scenes/levels/stage3/Level1.tscn"),
	#preload("res://scenes/levels/stage3/Level2.tscn"),
	#preload("res://scenes/levels/stage3/Level3.tscn")
]

var level_index: int = 0
var current_level: Level = null

func start_next_level() -> void:
	if current_level:
		current_level.queue_free()
	
	if level_index >= LEVELS.size():
		completed.emit()
		return
	
	current_level = LEVELS[level_index].instantiate()
	level_index += 1
	
	call_deferred("_add_level")

func _add_level() -> void:
	current_level.completed.connect(_on_level_completed, CONNECT_ONE_SHOT)
	get_tree().current_scene.add_child(current_level)
	
func _on_level_completed() -> void:
	start_next_level()
