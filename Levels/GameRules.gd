extends Node2D

func _ready():
	Globals.lives = 3
	Globals.coins = 100
	get_tree().call_group("GUI", "add_lives", Globals.lives)

func hurt():
	$Player.hurt()
	Globals.lives -= 1
	if Globals.lives < 1:
		end_game()
	get_tree().call_group("GUI", "remove_lives", Globals.lives)

func end_game():
	get_tree().change_scene("res://Scenes/Gameover.tscn")

func coin_up():
	Globals.coins += 1
	get_tree().call_group("GUI", "add_coins", Globals.coins)

func coin_dropped():
	Globals.coins -= 1
	get_tree().call_group("GUI", "add_coins", Globals.coins)
