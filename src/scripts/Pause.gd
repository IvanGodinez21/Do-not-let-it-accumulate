extends CanvasLayer

var mainScene = load("res://src/scenes/MainMenu.tscn")

func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if "Level-" in get_tree().get_current_scene().get_name():
			if !get_tree().get_current_scene().get_node("./GameOver").is_visible():
				$resumeButton.grab_focus()
				set_visible(!get_tree().paused)
				get_tree().paused = !get_tree().paused

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _reset():
	Resources.life = 3
	Resources.score = 0
	Resources.greenTrashBags = 0
	Resources.blueTrashBags = 0
	Resources.maxAccumulatedTrash = 0

func _on_resumeButton_pressed():
	get_tree().paused = false
	set_visible(false)

func _on_quitButton_pressed():
	get_tree().paused = false
	set_visible(false)
	get_tree().change_scene_to(mainScene)

func _on_restartButton_pressed():
	get_tree().paused = false
	set_visible(false)
	get_tree().change_scene_to(mainScene)
	_reset()
	get_tree().reload_current_scene()
