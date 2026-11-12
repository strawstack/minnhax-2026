extends Node3D

@export var playerStart: Node3D
@export var skateBoardBack: MeshInstance3D
@export var skateBoardFloor: MeshInstance3D
@export var noSkating: bool
@export var shootingAllowed: bool
@export var hideBoard: bool
@export var gunArm: Node3D
@export var rayCast3D: RayCast3D
@export var bulletStart: Node3D

var useWalkMovement = true
var inShootingMode = false

var currentEvent

var mouse_sens = 0.3

# Maximum look angles
const MAX_LOOK_UP = 80.0
const MAX_LOOK_DOWN = -80.0

var agentFortyJeffM
var characterBody3D
var rigidBody3D
var cameraY
var cameraX

var startCameraPosition: Vector3

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	agentFortyJeffM = $agentFortyJeffM
	characterBody3D = $CharacterBody3D
	rigidBody3D = $RigidBody3D
	cameraY = $CameraY
	cameraX = $CameraY/CameraX
	startCameraPosition = $CameraY/CameraX/Camera3D.get_position()
	
	if hideBoard:
		skateBoardBack.set_visible(false)
		skateBoardFloor.set_visible(false)
	
	setMovement(useWalkMovement)
	
	shootingMode(false)
	
	# Sync character movement bodies with playerStart
	if playerStart:
		if useWalkMovement:
			characterBody3D.set_position(playerStart.get_position())
		else:
			rigidBody3D.setTeleport(playerStart.get_position())

func resetCamera():
	cameraY.set_rotation(Vector3.ZERO)
	cameraX.set_rotation(Vector3.ZERO)

func setCameraActive():
	$CameraY/CameraX/Camera3D.set_current(true)

func _input(event):
	# https://forum.godotengine.org/t/how-to-make-the-camera-moves-by-the-mouse-in-3d/24201/2
	if event is InputEventMouseMotion and gc.playerCanMove:
		# Rotate player left/right
		cameraY.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))

		# Calculate new camera pitch
		var new_pitch = cameraX.rotation_degrees.x - event.relative.y * mouse_sens

		# Clamp pitch
		new_pitch = clamp(new_pitch, MAX_LOOK_DOWN, MAX_LOOK_UP)

		cameraX.rotation_degrees.x = new_pitch

func shootingMode(value: bool):
	inShootingMode = value
	gunArm.set_visible(value)
	agentFortyJeffM.hideHead(value)
	gc.showCrossHairs(value)
	if value:
		$CameraY/CameraX/Camera3D.set_position(Vector3(0, 0.75, 0))
	else:
		$CameraY/CameraX/Camera3D.set_position(startCameraPosition)

func _physics_process(delta: float) -> void:
	if inShootingMode and Input.is_action_just_pressed("left_mouse"):
		rayCast3D.force_raycast_update()
		if rayCast3D.is_colliding():
			var from = bulletStart.get_global_position()
			var to = rayCast3D.get_collision_point()
			gc.draw_thick_line(from, to)

func _process(delta: float) -> void:
	if not gc.playerCanMove:
		return

	if Input.is_action_just_pressed("right_mouse") and shootingAllowed:
		shootingMode(true)
	
	if Input.is_action_just_released("right_mouse"):
		shootingMode(false)

	if Input.is_action_just_pressed("f_key") and not noSkating:
		setMovement(not useWalkMovement)
	
	if Input.is_action_just_pressed("e_key"):
		if not gc.dialogInProgress and currentEvent:
			currentEvent.startEvent()

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

	if not hideBoard:
		skateBoardBack.set_visible(useWalkMovement)
		skateBoardFloor.set_visible(not useWalkMovement)

	characterBody3D.toggleActive(useWalkMovement)
	rigidBody3D.toggleActive(not useWalkMovement)

func _on_area_3d_area_entered(area: Area3D) -> void:
	var event = area.get_parent()
	if event:
		currentEvent = event
		event.showInteract()

func _on_area_3d_area_exited(area: Area3D) -> void:
	gc.hideInteract()
