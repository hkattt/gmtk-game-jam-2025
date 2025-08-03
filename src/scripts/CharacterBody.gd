class_name CharacterBody extends StaticBody2D

@onready var timer = $Timer

const DURATION: float = 6.0
const character_body_scene: PackedScene = preload("res://scenes/CharacterBody.tscn")

static func create(p_position: Vector2) -> CharacterBody:
	var character_body: CharacterBody = character_body_scene.instantiate()
	character_body.position = p_position
	return character_body

func _ready() -> void:
	timer.start(DURATION)

func _on_timer_timeout() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.finished.connect(_on_body_hidden, CONNECT_ONE_SHOT)
	
func _on_body_hidden() -> void:	
	queue_free()
