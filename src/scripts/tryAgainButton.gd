extends Button

var mainScene = load("res://src/scenes/Level-1.tscn")

func _on_startButton_pressed():
	_reset()
	get_tree().reload_current_scene()

func _reset():
	Resources.life = 3
	Resources.score = 0
	Resources.greenTrashBags = 0
	Resources.blueTrashBags = 0
	Resources.maxAccumulatedTrash = 0
