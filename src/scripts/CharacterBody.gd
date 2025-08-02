class_name CharacterBody extends StaticBody2D

@onready var timer = $Timer

const DURATION: float = 5.0
const character_body_scene: PackedScene = preload("res://scenes/CharacterBody.tscn")

static func create(p_position: Vector2) -> CharacterBody:
	var character_body: CharacterBody = character_body_scene.instantiate()
	character_body.position = p_position
	return character_body

func _ready() -> void:
	timer.start(DURATION)

func _on_timer_timeout() -> void:
	queue_free()
