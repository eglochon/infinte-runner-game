extends CanvasLayer
class_name GUI

@export var player: Player
@onready var score_label: Label = $PanelContainer/VBox/HBoxScore/Score
@onready var jumps_label: Label = $PanelContainer/VBox/HBoxJumps/Jumps

func _process(_delta: float) -> void:
	score_label.text = "Scores: " + str(Game.score)
	jumps_label.text = "Air Jumps: " + str(player.airjump_max - player.airjump_current) + "/" + str(player.airjump_max)
