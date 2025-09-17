extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var jump_sound: AudioStreamPlayer2D = $Jump
@onready var powerup_sound: AudioStreamPlayer2D = $PowerUp

const JUMP_VELOCITY: float = -300.0
const JUMP_CUTOFF_MULTIPLIER: float = 1.5

var airjump_max: int = 1
var airjump_current: int = 0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	Game.powerup.connect(_on_powerup)

func _physics_process(delta: float) -> void:
	var on_floor := is_on_floor()
	# var key_jump := Input.is_action_pressed("ui_jump")
	var key_jump_pressed := Input.is_action_just_pressed("ui_jump")
	var key_jump_released := Input.is_action_just_released("ui_jump")

	# Apply gravity by default
	if not on_floor:
		velocity.y += gravity * delta
	else:
		airjump_current = 0

	# Jump start (floor or air jump)
	if key_jump_pressed:
		if on_floor:
			velocity.y = JUMP_VELOCITY
			jump_sound.play()
		elif airjump_current < airjump_max:
			airjump_current += 1
			velocity.y = JUMP_VELOCITY
			jump_sound.play()

	# Jump cutoff (release button early)
	if key_jump_released and velocity.y > 0:
		velocity.y *= JUMP_CUTOFF_MULTIPLIER

	# Terminal velocity
	velocity.y = clamp(velocity.y, -1000, 1000)

	# Change Sprite animation
	if velocity.y != 0:
		sprite.pause()
	else:
		sprite.play("run")

	move_and_slide()

func _on_powerup() -> void:
	airjump_max += 1
	powerup_sound.play()
