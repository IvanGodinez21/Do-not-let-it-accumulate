extends Node2D

var mainScene = load("res://src/scenes/Level-1.tscn")

func _ready():
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene_to(mainScene)
