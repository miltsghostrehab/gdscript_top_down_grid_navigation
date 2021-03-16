extends KinematicBody2D

var dir_list = [
	"up",
	"right",
	"down",
	"left",
	]


func _ready():
	$AnimationPlayer.set_current_animation( "step_down" )


func _physics_process(_delta):
	for a in dir_list:
		var btn = "player_" + a
		if Input.is_action_pressed(btn):
			rotate_player("step_" + a)
		if Input.is_action_just_released(btn):
			rotate_player("facing_" + a)


func rotate_player(ani):
	$AnimationPlayer.set_current_animation( ani )
