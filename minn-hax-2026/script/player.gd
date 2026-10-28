extends Node3D

@export var playerStart: Node3D
@export var skateBoardBack: MeshInstance3D
@export var skateBoardFloor: MeshInstance3D

var useWalkMovement = true

var mouse_sens = 0.3

# Maximum look angles
const MAX_LOOK_UP = 80.0
const MAX_LOOK_DOWN = -80.0

var agentFortyJeffM
var characterBody3D
var rigidBody3D
var cameraY
var cameraX

func _ready() -> void:
	agentFortyJeffM = $agentFortyJeffM
	characterBody3D = $CharacterBody3D
	rigidBody3D = $RigidBody3D
	cameraY = $CameraY
	cameraX = $CameraY/CameraX
	
	setMovement(useWalkMovement)
	
	# Sync character movement bodies with playerStart
	if useWalkMovement:
		characterBody3D.set_position(playerStart.get_position())
	else:
		rigidBody3D.setTeleport(playerStart.get_position())

func _input(event):
	# https://forum.godotengine.org/t/how-to-make-the-camera-moves-by-the-mouse-in-3d/24201/2
	if event is InputEventMouseMotion:
		# Rotate player left/right
		cameraY.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))

		# Calculate new camera pitch
		var new_pitch = cameraX.rotation_degrees.x - event.relative.y * mouse_sens

		# Clamp pitch
		new_pitch = clamp(new_pitch, MAX_LOOK_DOWN, MAX_LOOK_UP)

		cameraX.rotation_degrees.x = new_pitch

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("f_key"):
		setMovement(not useWalkMovement)
	if useWalkMovement:
		var pos = characterBody3D.get_position()
		agentFortyJeffM.set_position(pos)
		cameraY.set_position(pos)
	else:
		var previous_position = agentFortyJeffM.get_position()
		var pos = rigidBody3D.get_position()
		var offset = agentFortyJeffM.global_basis.y.normalized() * 0.74
		agentFortyJeffM.set_position(lerp(previous_position, pos + offset, 18.0 * delta))
		cameraY.set_position(pos)

func setMovement(walk: bool):
	useWalkMovement = walk

	# Sync new player movement body with previous
	if useWalkMovement:
		$CameraY/CameraX/Camera3D.set_fov(75.0)
		characterBody3D.set_position(rigidBody3D.get_position())
	else:
		$CameraY/CameraX/Camera3D.set_fov(90.0)
		rigidBody3D.setTeleport(characterBody3D.get_position())

	skateBoardBack.set_visible(useWalkMovement)
	skateBoardFloor.set_visible(not useWalkMovement)
	
	characterBody3D.toggleActive(useWalkMovement)
	rigidBody3D.toggleActive(not useWalkMovement)
	
	
