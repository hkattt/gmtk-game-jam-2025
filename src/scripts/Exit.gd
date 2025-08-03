class_name Exit extends Area2D

signal exited

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		SoundManager.play_sound(SoundManager.Sound.EXIT)
		exited.emit()
