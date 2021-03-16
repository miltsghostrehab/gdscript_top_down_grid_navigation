extends KinematicBody2D

# possible movement directions
var dir_list = [
	"up",
	"right",
	"down",
	"left",
	]

# number of pixels to move per button press
const TILE_SIZE = 16.0
# speed of tween and animation scale
const SPEED = 4.0
# vector based on move direction
var d_input = Vector2.ZERO


func _ready():
	# character faces camera on load
	$AnimationPlayer.set_current_animation( "facing_down" )
	$AnimationPlayer.set_speed_scale(SPEED) # SPEED SCALE


func _physics_process(_delta):
	process_input()


func process_input():
	for a in dir_list:
		var btn = "player_" + a # ...clever ;-)
		# !Tween.is_active() helps verify that input can be accepted
		if Input.is_action_pressed(btn) and !$Tween.is_active():
			move()
			$AnimationPlayer.set_current_animation("step_" + a)
			yield($AnimationPlayer, "animation_finished") # hang on...
			$AnimationPlayer.set_current_animation("facing_" + a)
			print_debug($AnimationPlayer.get_current_animation())
		# NOTE: _literally_ the only difference between rouge and chimera
		# is that chimera allows you to hold the move button down


func move():
	# used to find out which direction to move
	# use "round" because joystick input can be less than 1
	d_input.x = round( Input.get_action_strength("player_right") - \
			Input.get_action_strength("player_left") )
	d_input.y = round( Input.get_action_strength("player_down") - \
			Input.get_action_strength("player_up") )

	$Tween.interpolate_property(
		self,
		"position",
		get_position(),
		get_position() + d_input * TILE_SIZE,
		1.0/SPEED, # DURATION
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
		)
	$Tween.start()


