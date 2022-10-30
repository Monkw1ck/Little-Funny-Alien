extends KinematicBody2D

const SPEED = 500
const JUMP_SPEED = 1000

onready var sprite = $Sprite
var boost_multiplayer = 1.5
var linear_velocity = Vector2(0, 0)
var facing = "right"

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	attack()
	move_and_slide(linear_velocity, Globals.UP)

func apply_gravity():
	if position.y > Globals.LEVEL_LIMIT:
		get_tree().call_group("Rules", "end_game")
	if is_on_floor() and linear_velocity.y > 0:
		linear_velocity.y = 0
	elif is_on_ceiling():
		linear_velocity.y = 1
	else:
		linear_velocity.y += Globals.GRAVITY

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		linear_velocity.y -= JUMP_SPEED
		$JumpSound.play()

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		linear_velocity.x = -SPEED
		facing = "left"
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		linear_velocity.x = SPEED
		facing = "right"
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
	
func attack():
	if Input.is_action_just_pressed("attack") and Globals.coins > 0:
		var projectile = load("res://Scenes/CoinProjectile.tscn").instance()
		if facing == "left":
			projectile.direction = -1
		elif facing == "right":
			projectile.direction = 1
		add_child(projectile)
		set_as_toplevel(true)
		get_tree().call_group("Rules", "coin_dropped")
		$Sprite.animation = "jump"
