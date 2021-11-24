extends KinematicBody2D

const SPEED = 428
const FLOOR = Vector2(0, -1)
const GRAVITY = 16
const JUMP_HEIGHT = 1084
onready var motion = Vector2.ZERO


func _process(_delta):
	motion_ctrl()

func start(new_position):
	position = new_position
	show()
	$Area2D/CollisionShape2D.disabled = false 
	$CollisionShape2D.disabled = false 
	

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


func _on_Area2D_body_entered(body):
	if "noxiousGas" in body.name:
		hide()  # Player disappears after being hit.
		$CollisionShape2D.set_deferred("disabled", true)
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		emit_signal("hit")	
		if ($HurtSound.playing == false):
			$HurtSound.play()
