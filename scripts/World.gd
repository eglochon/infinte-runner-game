extends Node2D

@export var player: Player
@onready var main_scene: PackedScene = load("res://scenes/Main.tscn")
@onready var game_canvas: CanvasLayer = $GUI
@onready var game_over_canvas: GameOverGUI = $GameOver

func _on_gameover() -> void:
	game_canvas.hide()
	game_over_canvas.toggle()
	get_tree().paused = true

func _on_reset() -> void:
	await get_tree().create_timer(0.1).timeout
	Game.reset()
	get_tree().paused = false
	game_canvas.show()
	game_over_canvas.hide()
	get_tree().reload_current_scene()

func _on_mainmenu() -> void:
	player.position.y = 0
	Game.reset()
	get_tree().paused = false
	game_canvas.show()
	game_over_canvas.hide()
	get_tree().change_scene_to_packed(main_scene)
