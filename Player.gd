extends KinematicBody2D

var linear_velocity = Vector2(0, 0)
const SPEED = 100

func _physics_process(delta):
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		linear_velocity.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		linear_velocity.x = SPEED
	else:
		linear_velocity.x = 0
	move_and_slide(linear_velocity)
