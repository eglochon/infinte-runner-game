extends Node2D

@onready var world_scene: PackedScene = preload("res://scenes/World.tscn")
@onready var exit_button: CenterContainer = $CanvasLayer/PanelContainer/VBoxContainer/CenterContainer3

func _ready() -> void:
	if not OS.has_feature("web"):
		exit_button.show()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(world_scene)

func _on_button_exit() -> void:
	if OS.has_feature("web"):
		get_tree().paused = true
	else:
		get_tree().quit()
