extends Button

var mainScene = load("res://src/scenes/Level-1.tscn")

func _on_startButton_pressed():
	get_tree().change_scene_to(mainScene)
