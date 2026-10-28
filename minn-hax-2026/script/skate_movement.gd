extends RigidBody3D

@export var playerRoot: Node3D

var agentFortyJeffM

func _ready() -> void:
	agentFortyJeffM = playerRoot.get_node("agentFortyJeffM")

func toggleActive(active: bool) -> void:
	$CollisionShape3D.set_disabled(not active)
	agentFortyJeffM.playAnimation("SkatePush")

func setTeleport(pos: Vector3) -> void:
	global_transform.origin = pos
