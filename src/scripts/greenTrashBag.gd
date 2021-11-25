extends RigidBody2D

export var min_speed = 600
export var max_speed = 600

func _ready():
	var player = get_tree().get_root().find_node("player", true, false)
	player.connect("greenTrashCollected", self, "_on_player_greenTrashCollected")
	var collectibleItem_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = collectibleItem_types[randi() % collectibleItem_types.size()]
	$AnimatedSprite.play()

func _on_VisibilityNotifier2D_screen_exited():
	if is_instance_valid(self):
		queue_free()

func _on_player_greenTrashCollected():
	pass
