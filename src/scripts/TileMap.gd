extends TileMap

signal gameOver

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if "TrashBag" in body.name:
		Resources.maxAccumulatedTrash += 1
		if Resources.maxAccumulatedTrash >= 5:
			emit_signal("gameOver", "You accumulated 5 trash bags in the ground")

func _on_Area2D_body_exited(body):
	if "TrashBag" in body.name:
		Resources.maxAccumulatedTrash -= 1
