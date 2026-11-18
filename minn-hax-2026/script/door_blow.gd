extends Area3D

@export var fakeDoor: Node3D
@export var pieces: Node3D

var random

func _ready() -> void:
	random = RandomNumberGenerator.new()

func _on_body_entered(body: Node3D) -> void:
	fakeDoor.set_visible(false)
	for piece: RigidBody3D in pieces.get_children():
		piece.set_freeze_enabled(false)
		var force_direction = Vector3(randf_range(-0.2, 0.2), randf_range(0.5, 0.9), -1).normalized()
		var force = randf_range(2, 3)
		piece.apply_central_impulse(force_direction * force)
		piece.apply_torque_impulse(Vector3(randf_range(-0.01, 0.01), randf_range(-0.01, 0.01), randf_range(-0.01, 0.01)))
