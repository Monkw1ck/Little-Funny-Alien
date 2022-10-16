extends Node2D

var lives = 3

func _ready():
	get_tree().call_group("GUI", "add_lives", lives)

func hurt():
	$Player.hurt()
	lives -= 1
	if lives < 1:
		end_game()
	get_tree().call_group("GUI", "remove_lives", lives)

func end_game():
	get_tree().change_scene("res://Scenes/Gameover.tscn")
