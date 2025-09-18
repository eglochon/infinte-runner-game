extends TileMapLayer
class_name Platform

var speed: float = 100.0
var size: int = 1
var level: int = 0
@onready var coin: PackedScene = preload("res://scenes/Coin.tscn")
var coins: Array[Coin] = []

func reset() -> void:
	speed = 100.0
	size = 1
	level = 0
	for icoin in coins:
		icoin.queue_free()
	coins.clear()

func _physics_process(delta: float) -> void:
	speed += delta
	if visible:
		position.x -= speed * delta

func set_platform(lvl: int) -> void:
	clear()
	level = lvl
	for i in range(size):
		set_cell(Vector2i(i, 0), 1, Vector2i(0,0), 0)

func add_coins() -> void:
	for icoin in coins:
		icoin.queue_free()
	coins.clear()
	for i in size:
		var coin_tmp = coin.instantiate()
		coin_tmp.position = map_to_local(Vector2i(i, 0)) + Vector2(0, -16)
		coin_tmp.show()
		add_child(coin_tmp)
		coins.append(coin_tmp)
