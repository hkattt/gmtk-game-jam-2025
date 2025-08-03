class_name Exit extends Area2D

signal exited

const AMPLITUDE: float = 5.0
const SPEED: float = 2.0

var resting_y: float = 0.0
var time: float = 0.0

func _ready():
	resting_y = position.y

func _process(delta: float) -> void:
	time += delta * SPEED
	position.y = resting_y + AMPLITUDE * sin(time)
	
func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		SoundManager.play_sound(SoundManager.Sound.EXIT, 10)
		var tween: Tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
		tween.finished.connect(_on_body_hidden, CONNECT_ONE_SHOT)	
	
func _on_body_hidden() -> void:	
	queue_free()
	exited.emit()
