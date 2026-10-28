extends RigidBody3D

@export var playerRoot: Node3D

const kick_force: float = 5.0
const steering_force: float = 1200.0

# refs
var agentFortyJeffM

# state
var kicking = false

func _ready() -> void:
	agentFortyJeffM = playerRoot.get_node("agentFortyJeffM")

func performKick():
	if not kicking:
		kicking = true
		agentFortyJeffM.setSpeed(3.0)
		agentFortyJeffM.playAnimation("SkatePush")
		apply_central_impulse(-agentFortyJeffM.global_basis.z.normalized() * kick_force)
		await agentFortyJeffM.get_node("AnimationPlayer").animation_finished
		kicking = false

func toggleActive(active: bool) -> void:
	$CollisionShape3D.set_disabled(not active)
	freeze = not active
	if active:
		performKick()

func setTeleport(pos: Vector3) -> void:
	global_transform.origin = pos

func _physics_process(delta: float) -> void:
	if playerRoot.useWalkMovement:
		return
	
	if linear_velocity.length() > 0.01:
		var offset = agentFortyJeffM.global_basis.y.normalized() * 0.74
		agentFortyJeffM.look_at(global_position + offset + linear_velocity, Vector3.UP)
	
	var steer = Vector3.UP.cross(linear_velocity).normalized() * steering_force * delta;
	
	if Input.is_action_pressed("right"):
		apply_central_force(-steer)

	if Input.is_action_pressed("left"):
		apply_central_force(steer)
	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("forward"):
		performKick()
