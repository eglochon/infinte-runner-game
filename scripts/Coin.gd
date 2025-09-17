extends Area2D
class_name Coin

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var sound: AudioStreamPlayer2D = $Sound

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Game.add_score()
		sprite.hide()
		sound.play()
