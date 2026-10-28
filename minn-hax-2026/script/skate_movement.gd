extends RigidBody3D

@export var playerRoot: Node3D

var steering_force: float = 12.0

var agentFortyJeffM

func _ready() -> void:
	agentFortyJeffM = playerRoot.get_node("agentFortyJeffM")

func toggleActive(active: bool) -> void:
	$CollisionShape3D.set_disabled(not active)
	agentFortyJeffM.setSpeed(3.0)
	agentFortyJeffM.playAnimation("SkatePush")

func setTeleport(pos: Vector3) -> void:
	global_transform.origin = pos

func _physics_process(_delta: float) -> void:
	if playerRoot.useWalkMovement:
		return
	if linear_velocity.length() > 0.01:
		agentFortyJeffM.look_at(global_position + linear_velocity, Vector3.UP)
