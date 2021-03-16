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
	$AnimationPlayer.set_current_animation( "facing_up" )
	$AnimationPlayer.set_speed_scale(SPEED) # SPEED SCALE


func _physics_process(_delta):
	process_input()


func process_input():
	# use button press strength for movement length _and_ input differentiation
	d_input.x = round( Input.get_action_strength("player_right") - \
			Input.get_action_strength("player_left") )
	d_input.y = round( Input.get_action_strength( "player_down") - \
			Input.get_action_strength( "player_up" ) )

	if !$Tween.is_active():
		# just make sure input is happening
		if d_input.y != 0:
			move(d_input.y)

		# if you could hold input down, turning would happen _every tick_
		if Input.is_action_just_pressed("player_right") \
				or Input.is_action_just_pressed("player_left"):
			turn(d_input.x)


func move(dir):
	var move = find_move_vector()

	$Tween.interpolate_property(
		self,
		"position",
		get_position(),
		get_position() - move * TILE_SIZE * dir,
		1.0/SPEED, # DURATION
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
		)
	$Tween.start()

	play_ani()


func turn(dir):
	# dir_list order is important for this to work
	var face = get_facing()
	var c_idx = dir_list.find(face)
	var idx

	if c_idx + dir >= dir_list.size():
		idx = 0
	elif c_idx + dir < 0:
		idx = dir_list.size() - 1
	else:
		idx = c_idx + dir

	$AnimationPlayer.set_current_animation("facing_" + str(dir_list[idx]))


func find_move_vector():
	var face = get_facing()

	# I wish I had a cleaner implementation
	match face:
		"up":
			return Vector2.UP
		"right":
			return Vector2.RIGHT
		"down":
			return Vector2.DOWN
		"left":
			return Vector2.LEFT


func play_ani():
	var face = get_facing()
	$AnimationPlayer.set_current_animation("step_" + face)

	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.set_current_animation("facing_" + face)


func get_facing():
	# animation names must be unchanged for this to work
	return $AnimationPlayer.get_assigned_animation()\
			.trim_prefix("facing_")\
			.trim_prefix("step_")
