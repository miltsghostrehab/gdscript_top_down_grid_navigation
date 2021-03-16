extends Node

var ctrl_var = [
	preload("res://test/player.tscn"),
	preload("res://rogue/player.tscn"),
	preload("res://rogue_tween/player.tscn"),
	]
var x = ctrl_var.size() - 1
var player


func _ready():
	yield($Camera2D, "ready")
	player = ctrl_var[x].instance()
	player.set_position($Camera2D.get_position())
	add_child(player)
	print_tree_pretty()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("player_switch"):
		x -= 1

		# TODO function to destroy current player and create the next one in
		# same position; make sure to snap to the grid

