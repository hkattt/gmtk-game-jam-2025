class_name MainMenu extends Node2D

signal started 

@onready var version_label: Label = $Control/VersionLabelMarginContainer/VersionLabel

func _ready() -> void:
	var version: String = ProjectSettings.get_setting("application/config/version")
	version_label.text = "v{version}".format({"version": version})

func _on_button_pressed() -> void:
	started.emit()
