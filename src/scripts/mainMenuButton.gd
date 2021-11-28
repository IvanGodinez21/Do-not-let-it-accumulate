extends Button

var level1Scene = load("res://src/scenes/MainMenu.tscn")

func _on_startButton_pressed():
	_reset()
	get_tree().change_scene_to(level1Scene)

func _reset():
	Resources.life = 3
	Resources.score = 0
	Resources.greenTrashBags = 0
	Resources.blueTrashBags = 0
	Resources.maxAccumulatedTrash = 0
