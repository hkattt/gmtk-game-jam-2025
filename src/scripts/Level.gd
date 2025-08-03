class_name Level extends Node2D

signal completed

@onready var character: Character = $Character
@onready var exit: Exit = $Exit
@onready var respawn_point: Node2D = $RespawnPoint
@onready var loop_time: Label = $LoopTime

func _ready() -> void:
	character.died.connect(_on_character_died)
	exit.exited.connect(_on_level_exited, CONNECT_ONE_SHOT)
	respawn_point.position = character.position
	
func _process(_delta: float) -> void:
	if character.can_loop:
		loop_time.text = "Loop time: {time}".format({"time": round(character.remaining_loop_time * 100) / 100})
		
func _on_level_exited() -> void:
	completed.emit()
	
func _on_character_died() -> void:
	character.position = respawn_point.position
	character.scale = Vector2(1.0, 1.0)
