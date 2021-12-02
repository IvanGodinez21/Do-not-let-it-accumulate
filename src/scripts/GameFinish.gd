extends Node2D

var mainMenuScene = load("res://src/scenes/MainMenu.tscn")
var level1Scene = load("res://src/scenes/Level-1.tscn")

func _ready():
	$mainMenuButton.grab_focus()
	if $congratulationsSound.playing == false:
		$congratulationsSound.play()

func _on_mainMenuButton_pressed():
	_reset()
	get_tree().change_scene_to(mainMenuScene)

func _on_playAgainButton_pressed():
	_reset()
	get_tree().change_scene_to(level1Scene)

func _reset():
	Resources.life = 3
	Resources.score = 0
	Resources.greenTrashBags = 0
	Resources.blueTrashBags = 0
	Resources.maxAccumulatedTrash = 0
