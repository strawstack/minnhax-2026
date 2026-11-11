extends CharacterBody3D

var agent
var greenDay

var driveSpeed = 10
var turnSpeed = 1
var slowForce = 0.90
var cutOff = 0.01

var mouse_sens = 0.3

# Maximum look angles
const MAX_LOOK_UP = 20.0
const MAX_LOOK_DOWN = -20.0

var cameraY
var cameraX

var canDrive = false

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	cameraY = $CameraY
	cameraX = $CameraY/CameraX
	agent = $Armature
	greenDay = $Armature_001
	agent.set_visible(false)
	greenDay.set_visible(false)

func showPassengers():
	agent.set_visible(true)
	greenDay.set_visible(true)
	$CameraY/CameraX/Camera3D.set_current(true)

func _input(event):
	# https://forum.godotengine.org/t/how-to-make-the-camera-moves-by-the-mouse-in-3d/24201/2
	if event is InputEventMouseMotion and canDrive:
		# Rotate player left/right
		cameraY.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))

		# Calculate new camera pitch
		var new_pitch = cameraX.rotation_degrees.x - event.relative.y * mouse_sens

		# Clamp pitch
		new_pitch = clamp(new_pitch, MAX_LOOK_DOWN, MAX_LOOK_UP)

		cameraX.rotation_degrees.x = new_pitch

func _process(delta: float) -> void:
	if not canDrive:
		return

	var moving = false

	if Input.is_action_pressed("forward") or Input.is_action_pressed("back"):
		moving = true
	
	if Input.is_action_pressed("left"):
		rotate(Vector3.UP, delta * turnSpeed)

	if Input.is_action_pressed("right"):
		rotate(Vector3.UP, -1 * delta * turnSpeed)

	if moving:
		velocity = -1 * get_global_basis().z * driveSpeed
	else:
		velocity = velocity * slowForce
		if velocity.length() <= cutOff:
			velocity = Vector3.ZERO

	move_and_slide()
