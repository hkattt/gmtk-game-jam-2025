class_name Level extends Node2D

signal completed

@onready var exit = $Exit

func _ready() -> void:
	exit.exited.connect(_on_level_exited, CONNECT_ONE_SHOT)
	
func _on_level_exited() -> void:
	completed.emit()
