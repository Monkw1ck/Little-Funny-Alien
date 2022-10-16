extends Area2D

func _on_Spring_body_entered(body):
	$Sprite.texture = load("res://Graphics/Items/springboardUp.png")
	$AudioStreamPlayer.play()
	if body.has_method("boost"):
		body.boost()
	$Timer.start()


func _on_Timer_timeout():
	$Sprite.texture = load("res://Graphics/Items/springboardDown.png")
