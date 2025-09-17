extends CanvasLayer
class_name GameOverGUI

@onready var score_label: Label = $Background/CenterContainer/VBoxContainer/Score
@onready var hurt_sound: AudioStreamPlayer2D = $Hurt

signal reset
signal mainmenu

func toggle() -> void:
	hurt_sound.play()
	score_label.text = "Your Score: " + str(Game.score)
	show()

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_accept"):
		emit_signal("reset")

func _on_button_pressed() -> void:
	emit_signal("reset")

func _on_button_pressed2() -> void:
	emit_signal("mainmenu")
