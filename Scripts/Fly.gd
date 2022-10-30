extends Node2D

var timeout = false

func _ready():
	$Area2D/AnimationPlayer.current_animation = "fly"	


func _process(delta):
	if $Area2D/RayCast2D.is_colliding():
		fire()


func fire():
	if not timeout:
		$Area2D/RayCast2D.add_child(load("res://Scenes/FlyFireball.tscn").instance())
		$Area2D/FireTimer.start()
		timeout = true

func _on_FireTimer_timeout():
	timeout = false


func fly_moving_left():
	Globals.fly_moving = "left"


func fly_moving_right():
	Globals.fly_moving = "right"
