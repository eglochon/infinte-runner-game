extends Node
class_name PlatformSpawner

@export var player: Player

var platform_scene: PackedScene = preload("res://scenes/Platform.tscn")
var platform_pool: Array[Platform] = []
var platform_last_placed: Platform
var pool_size: int = 15

signal gameover()

func _ready() -> void:
	for i in range(pool_size):
		var plarform_tmp: Platform = platform_scene.instantiate()
		plarform_tmp.size = 2
		plarform_tmp.set_platform(12)
		plarform_tmp.position = Vector2(i*(16*2), 192)
		plarform_tmp.show()
		platform_pool.append(plarform_tmp)
		add_child(plarform_tmp)
		platform_last_placed = plarform_tmp

func reset() -> void:
	for platform in platform_pool:
		platform.reset()

func _physics_process(_delta: float) -> void:
	if player.position.x < -100 or player.position.y > 256:
		emit_signal("gameover")

	for platform in platform_pool:
		var tail_pos = platform.position.x + platform.size * 16
		if tail_pos < 0:
			_reset_platform(platform)
			add_platform()

func _reset_platform(platform: Node2D) -> void:
	platform.hide()

#func create_platform() -> Platform:
#	for platform in platform_pool:
#		if not platform.visible:
#			return platform

#	var platform: Platform = platform_scene.instantiate()
#	platform.hide()
#	platform_pool.append(platform)
#	pool_size += 1
#	add_child(platform)
#	return platform

func add_platform() -> void:
	var spawn_pos_x: float
	var p: Platform
	var added_space: int = clampi(2 * Game.powerups, 0, 12)
	var min_space_between: int = clampi(1 + Game.powerups, 0, 6)
	var max_space_between: int = clampi(3 + Game.powerups, 0, 20)
	for platform in platform_pool:
		if not platform.visible:
			var pos: int = platform_pool.find(platform)
			platform.show()
			platform.size = randi_range(3, 5)
			var prev_level = platform_last_placed.level
			var platform_level = randi_range(5, 12)
			var diff = clampi(platform_level - prev_level, -5 - added_space, 5 + added_space)
			platform_level = prev_level + diff
			platform.position.y = platform_level * 16

			var space_between = randi_range(min_space_between, max_space_between) * 16
			if pos > 0:
				p = platform_pool[pos-1]
				spawn_pos_x = p.global_position.x + (p.size * 16) + space_between
			else:
				p = platform_pool[pool_size-1]
				spawn_pos_x = p.global_position.x + (p.size * 16) + space_between
			platform.position.x = spawn_pos_x

			platform.set_platform(platform_level)
			platform.add_coins()
			platform_last_placed = platform
