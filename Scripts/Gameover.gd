extends Control

func _on_ButtonRestart_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_ButtonQuit_pressed():
	get_tree().quit()
