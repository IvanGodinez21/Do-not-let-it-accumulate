extends KinematicBody2D

var life = Resources.life
var greenTrashBags = Resources.greenTrashBags
var blueTrashBags = Resources.blueTrashBags
var badPoints = Resources.badPoints
var maxBags = Resources.maxBags

export var move_speed = 400
var velocity = Vector2.ZERO
export var jump_height = 130
export var jump_time_to_peak = 0.25
export var jump_time_to_descent = 0.25

onready var jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

signal playerHit
signal gameOver
signal greenTrashCollected
signal blueTrashCollected

func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.set_deferred("disabled", false)
	yield(get_tree().create_timer(1.5), "timeout")
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	#$Area2D/CollisionShape2D.disabled = false
	#$CollisionShape2D.disabled = false

func respawn():
	yield(get_tree().create_timer(1.5), "timeout")
	position.x = 512
	position.y = 550
	start(position)

func _physics_process(delta):
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * move_speed
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		if ($JumpSound.playing == false):
				$JumpSound.play()
		jump()
	
	velocity = move_and_slide(velocity, Vector2.UP)

func get_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

func get_input_velocity():
	var horizontal = 0.0
	if Input.is_action_pressed("ui_left"):
		horizontal -= 1.0
		$Sprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		horizontal += 1.0
	if horizontal == 0:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("walk")
		if is_on_floor():
			if ($FootStepsSound.playing == false):
				$FootStepsSound.play()
	return horizontal

func _on_player_playerHit():
	if !$CollisionShape2D.disabled && !$Area2D/CollisionShape2D.disabled:
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		Resources.life -= 1
		get_node("../HUD/lifeCounter").text = str("x", Resources.life)
		if (Resources.life > 0):
			if ($HurtSound.playing == false):
				$HurtSound.play()
			respawn()
		else:
			if ($DeathSound.playing == false):
				$DeathSound.play()
			emit_signal("gameOver", "You lose all your health points")

func _on_Area2D_body_entered(body):
	if "noxiousGas" in body.name:
		emit_signal("playerHit")
	if "greenTrashBag" in body.name:
		emit_signal("greenTrashCollected", body)
	if "blueTrashBag" in body.name:
		emit_signal("blueTrashCollected", body)
