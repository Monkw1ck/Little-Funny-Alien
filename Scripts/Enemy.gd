extends Area2D


func _on_Enemy_body_entered(body):
	if body.has_method("hurt"):
		get_tree().call_group("Rules", "hurt")
		body.hurt()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Projectile"):
		$Timer.start()
		$AudioStreamPlayer2D.play()
		$CollisionShape2D.queue_free()
		$AnimatedSprite.hide()


func _on_Timer_timeout():
	get_parent().queue_free()


func _on_StompDetector_area_entered(area):
	if area.global_position.y < get_parent().global_position.y:
		$Timer.start()
		$AudioStreamPlayer2D.play()
		$CollisionShape2D.queue_free()
		$AnimatedSprite.hide()
		$StompDetector.queue_free()

