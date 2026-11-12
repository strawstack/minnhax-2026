extends RigidBody3D

@export var agentFortyJeffM: Node3D
@export var playerRoot: Node3D
@export var cameraY: Node3D

const jump_force: float = 4
const move_force: float = 4

var onceTransferVelocity = false

var gc

func _ready() -> void:
	gc = get_tree().current_scene

func toggleActive(active: bool) -> void:
	freeze = not active
	if not active:
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		onceTransferVelocity = false

func setTeleport(pos: Vector3) -> void:
	global_transform.origin = pos

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if not onceTransferVelocity:
		onceTransferVelocity = true
		state.linear_velocity = playerRoot.preserveVelocity

func _physics_process(delta: float) -> void:
	if not gc.playerCanMove or playerRoot.useWalkMovement:
		return

	if Input.is_action_just_pressed("jump"):
		apply_central_impulse(Vector3.UP * jump_force)
	if cameraY:
		if Input.is_action_pressed("forward"):
			apply_central_force(-cameraY.get_global_basis().z * move_force)
		if Input.is_action_pressed("left"):
			apply_central_force(-cameraY.get_global_basis().x * move_force)
		if Input.is_action_pressed("right"):
			apply_central_force(cameraY.get_global_basis().x * move_force)
		if Input.is_action_pressed("back"):
			apply_central_force(cameraY.get_global_basis().z * move_force)
