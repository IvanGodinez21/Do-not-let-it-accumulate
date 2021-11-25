extends Node2D

var noxiousGas = preload("res://src/scenes/noxiousGas.tscn")
var greenTrashBag = preload("res://src/scenes/greenTrashBag.tscn")
var blueTrashBag = preload("res://src/scenes/blueTrashBag.tscn")

func _ready():
	randomize()

func _on_MobSpawnTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = rand_range(0.0, 0.287)
	var mob = noxiousGas.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)

func _on_CollectibleItemSpawnTimer_timeout():
	var collectibleItem_spawn_location = $MobPath/MobSpawnLocation
	collectibleItem_spawn_location.unit_offset = rand_range(0.1, 0.2)
	var randomTrash = randi() % 2 + 1
	var collectibleItem
	match randomTrash:
		1:
			collectibleItem = greenTrashBag.instance()
		2:
			collectibleItem = blueTrashBag.instance()
	add_child(collectibleItem)
	
	collectibleItem.position = collectibleItem_spawn_location.position
	
	var direction = collectibleItem_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	collectibleItem.rotation = 0
	
	var velocity = Vector2(rand_range(collectibleItem.min_speed, collectibleItem.max_speed), 0)
	collectibleItem.linear_velocity = velocity.rotated(direction)
