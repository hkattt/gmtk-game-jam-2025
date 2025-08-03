class_name Level extends Node2D

signal completed

@onready var character: Character = $Character
@onready var exit: Exit = $Exit
@onready var respawn_point: Node2D = $RespawnPoint

func _ready() -> void:
	character.died.connect(_on_character_died)
	exit.exited.connect(_on_level_exited, CONNECT_ONE_SHOT)
	respawn_point.position = character.position
	
func _on_level_exited() -> void:
	completed.emit()
	
func _on_character_died() -> void:
	character.position = respawn_point.position
