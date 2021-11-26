extends KinematicBody2D

var extraPoints = 30

func _ready():
	var greenTrashCan_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = greenTrashCan_types[randi() % greenTrashCan_types.size()]
	$AnimatedSprite.play()

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		if body.is_visible_in_tree():
			if (Resources.blueTrashBags == 3):
				Resources.blueTrashBags = 0
				Resources.score += extraPoints
				get_node("../HUD/blueTrashBagsCollected").text = str("--")
				get_node("../HUD/scorePoints").text = str(Resources.score)
				if $depositSound.playing == false:
					$depositSound.play()