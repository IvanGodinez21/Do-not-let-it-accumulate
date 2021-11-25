extends KinematicBody2D

var life = Resources.life
var greenTrashBags = Resources.greenTrashBags
var blueTrashBags = Resources.blueTrashBags
var badPoints = 10
var maxBags = 3

const SPEED = 450
const FLOOR = Vector2(0, -1)
const GRAVITY = 16
const JUMP_HEIGHT = 1400
onready var motion = Vector2.ZERO

signal playerHit
signal greenTrashCollected
signal blueTrashCollected

func _process(_delta):
	motion_ctrl()

func start(new_position):
	position = new_position
	show()
	$Area2D/CollisionShape2D.disabled = false 
	$CollisionShape2D.disabled = false 

func respawn():
	yield(get_tree().create_timer(2), "timeout")
	$CollisionShape2D.set_deferred("disabled", false)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	position.x = 512
	position.y = 550
	start(position)

func displayFail():
	print("GG")

func get_axis() -> Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis

func motion_ctrl():
	motion.y += GRAVITY
	
	if get_axis().x == 1:
		$Sprite.flip_h = false
	elif get_axis().x == -1:
		$Sprite.flip_h = true
	
	if get_axis().x != 0:
		motion.x =  get_axis().x * SPEED
	else:
		motion.x = 0
	
	if is_on_floor():
		if get_axis().x != 0:
			$AnimationPlayer.play("walk")
			if ($FootStepsSound.playing == false):
				$FootStepsSound.play()
		else:
			$AnimationPlayer.play("idle")
		
		if (Input.is_action_just_pressed("ui_up")):
			motion.y -= JUMP_HEIGHT
	else:
		if motion.y < 0:
			pass
			#$AnimationPlayer.play("jump")
		else:
			pass
			#$AnimationPlayer.play("fall")
	
	motion = move_and_slide(motion, FLOOR)

func _on_player_playerHit():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	Resources.life -= 1
	get_node("../HUD/lifeCounter").text = str("x", Resources.life)
	if ($HurtSound.playing == false):
		$HurtSound.play()
	if (Resources.life > 0):
		respawn()
	else:
		displayFail()

func _on_Area2D_body_entered(body):
	print(body)
	if "noxiousGas" in body.name:
		emit_signal("playerHit")
	elif "greenTrashBag" in body.name:
		#emit_signal("greenTrashCollected")
		if body.is_visible_in_tree():
			if (Resources.greenTrashBags < maxBags):
				if (Resources.blueTrashBags > 0):
					Resources.greenTrashBags = 0
					Resources.blueTrashBags = 0
					Resources.score -= badPoints
					get_node("../HUD/greenTrashBagsCollected").text = str("--")
					get_node("../HUD/blueTrashBagsCollected").text = str("--")
					get_node("../HUD/scorePoints").text = str(Resources.score)
				else:
					Resources.greenTrashBags += 1
					Resources.blueTrashBags = 0
					get_node("../HUD/greenTrashBagsCollected").text = str("x", Resources.greenTrashBags)
					get_node("../HUD/blueTrashBagsCollected").text = str("--")
				if body.get_node("./CollectSound").playing == false:
					body.get_node("./CollectSound").play()
				body.hide()
				body.get_node("./CollisionShape2D").set_deferred("disabled", true)
				yield(get_tree().create_timer(2.0), "timeout")
				if is_instance_valid(body):
					body.queue_free()
	elif "blueTrashBag" in body.name:
		#emit_signal("blueTrashCollected")
		if body.is_visible_in_tree():
			if (Resources.blueTrashBags < maxBags):
				if (Resources.greenTrashBags > 0):
					Resources.blueTrashBags = 0
					Resources.greenTrashBags = 0
					Resources.score -= badPoints
					get_node("../HUD/blueTrashBagsCollected").text = str("--")
					get_node("../HUD/greenTrashBagsCollected").text = str("--")
					get_node("../HUD/scorePoints").text = str(Resources.score)
				else:
					Resources.blueTrashBags += 1
					Resources.greenTrashBags = 0
					get_node("../HUD/blueTrashBagsCollected").text = str("x", Resources.blueTrashBags)
					get_node("../HUD/greenTrashBagsCollected").text = str("--")
				if body.get_node("./CollectSound").playing == false:
					body.get_node("./CollectSound").play()
				body.hide()
				body.get_node("./CollisionShape2D").set_deferred("disabled", true)
				yield(get_tree().create_timer(2.0), "timeout")
				if is_instance_valid(body):
					body.queue_free()
