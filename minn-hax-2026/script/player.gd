extends CharacterBody3D

var mouse_sens = 0.3

var walkSpeed = 4
var runSpeed = 8
var speed = walkSpeed

# Maximum look angles
const MAX_LOOK_UP = 80.0
const MAX_LOOK_DOWN = -80.0

const gravity = 20
const jump_height = 2

const small = 0.01

# Tracks player rotation to set Idle facing direction
var previous_rotation = -PI/2

# Capture mouse when game launches
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):

	# Capture mouse on left click
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# Free mouse on esc
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# https://forum.godotengine.org/t/how-to-make-the-camera-moves-by-the-mouse-in-3d/24201/2
	if event is InputEventMouseMotion:
		# Rotate player left/right
		$Node3D.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))

		# Calculate new camera pitch
		var camera = $Node3D/Node3D
		var new_pitch = camera.rotation_degrees.x - event.relative.y * mouse_sens

		# Clamp pitch
		new_pitch = clamp(new_pitch, MAX_LOOK_DOWN, MAX_LOOK_UP)

		camera.rotation_degrees.x = new_pitch

# Called on every physics frame
func _physics_process(delta):

	# Set player direction to Zero 
	var direction = Vector3.ZERO

	# Obtain forward and right directions based on rotation of Camera Pivot
	var forward = -1 * $Node3D.get_global_transform().basis.z
	var right = $Node3D.get_global_transform().basis.x

	# Increase speed when shift is held
	if Input.is_action_pressed("run"):
		speed = runSpeed
		$agentFortyJeffM.setSpeed(3)
	else:
		speed = walkSpeed
		$agentFortyJeffM.setSpeed(1.8)

	# Add up current player direction based on input 
	if Input.is_action_pressed("right"):
		direction += right

	if Input.is_action_pressed("left"):
		direction += -1 * right

	if Input.is_action_pressed("back"):
		direction += -1 * forward

	if Input.is_action_pressed("forward"):
		direction += forward

	# Gravity
	if !is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = sqrt(2.0 * gravity * jump_height)

	var dir = direction.normalized()
	var target_rotation = atan2(dir.x, dir.z) + PI / 2
	if dir.length() < small:
		target_rotation = previous_rotation
		$agentFortyJeffM.playAnimation("Idle")
	else:
		$agentFortyJeffM.playAnimation("RunAction")
	previous_rotation = target_rotation
	$agentFortyJeffM.rotation.y = lerp_angle(
		$agentFortyJeffM.rotation.y,
		target_rotation,
		10.0 * delta
	)
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed

	# Move the player while respecting physics bounds
	move_and_slide()
