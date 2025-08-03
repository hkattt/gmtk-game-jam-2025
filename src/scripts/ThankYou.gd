class_name ThankYou extends Node2D

@onready var timer: Timer = $Timer 

signal completed

func _ready() -> void:
	timer.start(3.0)

func _on_timer_timeout() -> void:
	completed.emit()
