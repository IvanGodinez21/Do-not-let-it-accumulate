extends RigidBody2D

export var min_speed = 500
export var max_speed = 600

var badPoints = Resources.badPoints
var maxBags = Resources.maxBags

func _ready():
	var player = get_tree().get_root().find_node("player", true, false)
	player.connect("blueTrashCollected", self, "_on_player_blueTrashCollected")
	var collectibleItem_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = collectibleItem_types[randi() % collectibleItem_types.size()]
	$AnimatedSprite.play()

func _on_VisibilityNotifier2D_screen_exited():
	if is_instance_valid(self):
		queue_free()

func _on_player_blueTrashCollected(body):
	if body.is_visible_in_tree():
			if (Resources.blueTrashBags < maxBags):
				if (Resources.greenTrashBags > 0):
					Resources.blueTrashBags = 1
					Resources.greenTrashBags = 0
					Resources.score -= badPoints
					get_node("../../HUD/blueTrashBagsCollected").text = str("x", Resources.blueTrashBags)
					get_node("../../HUD/greenTrashBagsCollected").text = str("--")
					get_node("../../HUD/scorePoints").text = str(Resources.score)
				else:
					Resources.blueTrashBags += 1
					Resources.greenTrashBags = 0
					get_node("../../HUD/blueTrashBagsCollected").text = str("x", Resources.blueTrashBags)
					get_node("../../HUD/greenTrashBagsCollected").text = str("--")
				if body.get_node("./CollectSound").playing == false:
					body.get_node("./CollectSound").play()
				body.hide()
				body.get_node("./CollisionShape2D").set_deferred("disabled", true)
				yield(get_tree().create_timer(2.0), "timeout")
				if is_instance_valid(body):
					body.queue_free()
