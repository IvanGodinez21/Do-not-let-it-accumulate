extends Node2D

var mainScene = load("res://src/scenes/Level-1.tscn")

func _ready():
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene_to(mainScene)

func _on_startButton_pressed():
	get_tree().change_scene_to(mainScene)

func _on_helpButton_pressed():
	$Rules.show()

func _on_controlsButton_pressed():
	$Controls.show()

func _on_exitButton_pressed():
	if OS.has_feature("JavaScript"):
		JavaScript.eval("window.close()")
	else:
		get_tree().quit()

func _on_rulesExitButton_pressed():
	$Rules.hide()

func _on_controlsExitButton_pressed():
	$Controls.hide()
