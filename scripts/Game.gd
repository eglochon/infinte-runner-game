extends Node

var score = 0
var powerups = 0

signal powerup

func reset() -> void:
	score = 0

func add_score() -> void:
	score += 1
	if score > 0 and score % 25 == 0:
		powerups += 1
		emit_signal("powerup")
