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
# used to verify that input can be accepted
# admittedly, a bit ugly
var is_moving = false
# vector based on move direction
var d_input = Vector2.ZERO


func _ready():
	# character faces camera on load
	$AnimationPlayer.set_current_animation( "facing_down" )


func _physics_process(_delta):
	process_input()


func process_input():
	for a in dir_list:
		var btn = "player_" + a
		# make sure to toggle is_moving before and after move
		if Input.is_action_just_pressed(btn) and !is_moving:
			is_moving = true
			move()
			$AnimationPlayer.set_current_animation("facing_" + a)
			print_debug($AnimationPlayer.get_current_animation())
			is_moving = false


func move():
	# used to find out which direction to move
	# use "round" because joystick input can be less than 1
	d_input.x = round( Input.get_action_strength("player_right") - \
			Input.get_action_strength("player_left") )
	d_input.y = round( Input.get_action_strength("player_down") - \
			Input.get_action_strength("player_up") )

	self.position += d_input * TILE_SIZE


