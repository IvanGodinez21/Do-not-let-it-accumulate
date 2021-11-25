extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

func _ready():
	var player = get_tree().get_root().find_node("player", true, false)
	player.connect("playerHit", self, "_on_player_playerHit")
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	$AnimatedSprite.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_player_playerHit():
	if ($GasSound.playing == false):
		$GasSound.play()
