extends Button

var mainScene = load("res://src/scenes/Level-1.tscn")

func _ready():
	pass # Replace with function body.

func _on_startButton_pressed():
	get_tree().change_scene_to(mainScene)
