extends KinematicBody2D

var linear_velocity = Vector2(0, 0)
const SPEED = 500
const GRAVITY = 55
const UP = Vector2(0, -1)
const JUMP_SPEED = 1000
const LEVEL_LIMIT = 2000
onready var sprite = $Sprite
var boost_multiplayer = 1.5

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(linear_velocity, UP)

func apply_gravity():
	if position.y > LEVEL_LIMIT:
		get_tree().call_group("Rules", "end_game")
	if is_on_floor() and linear_velocity.y > 0:
		linear_velocity.y = 0
	elif is_on_ceiling():
		linear_velocity.y = 1
	else:
		linear_velocity.y += GRAVITY

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		linear_velocity.y -= JUMP_SPEED
		$JumpSound.play()

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		linear_velocity.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		linear_velocity.x = SPEED
	else:
		linear_velocity.x = 0

func animate():
	if linear_velocity.y < 0:
		sprite.play("jump")
	elif linear_velocity.x > 0:
		sprite.flip_h = false
		sprite.play("walk")
	elif linear_velocity.x < 0:
		sprite.flip_h = true
		sprite.play("walk")
	else:
		sprite.play("idle") 

func hurt():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	linear_velocity.y = -(JUMP_SPEED * 0.85)
	$PainSound.play()

func boost():
	linear_velocity.y = -JUMP_SPEED * boost_multiplayer
