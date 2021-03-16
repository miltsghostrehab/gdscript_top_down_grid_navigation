extends Node2D

var ctrl_var = [
	preload("res://modern/player.tscn"),
	preload("res://tank/player.tscn"),
	preload("res://ff/player.tscn"),
	preload("res://test/player.tscn"),
	preload("res://rogue/player.tscn"),
	preload("res://rogue_tween/player.tscn"),
	]
var x = 0
var player
const TILE_SIZE = 16.0


func _ready():
	load_player(Vector2(248,152))


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("player_switch"):
		if x >= ( ctrl_var.size() - 1 ):
			x = 0
		else:
			x += 1

		var c_pos = get_snapped_position(player)
		pop_player()
		load_player(c_pos)


func pop_player():
	remove_child(player)
	player.queue_free()


func load_player(pos):
	player = ctrl_var[x].instance()
	player.set_position(pos)
	$canvas_layer/current.set_text(player.get_name())
	add_child(player)


func get_snapped_position(obj):
	var sloppy_pos = obj.get_position()
	var clean_pos = Vector2.ZERO
	clean_pos.x = ceil(sloppy_pos.x / TILE_SIZE) \
			* TILE_SIZE - ( TILE_SIZE / 2 )
	clean_pos.y = ceil(sloppy_pos.y / TILE_SIZE) \
			* TILE_SIZE - ( TILE_SIZE / 2 )
	return clean_pos

