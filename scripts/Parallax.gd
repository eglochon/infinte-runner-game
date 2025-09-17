extends ParallaxBackground

@onready var speed: int = 10

func _process(delta: float) -> void:
	scroll_offset.x -= speed * delta
