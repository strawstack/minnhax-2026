extends Node3D

@export var windowRoof: MeshInstance3D

func _ready() -> void:
	pass

func fall():
	windowRoof.set_visible(false)
	for piece: RigidBody3D in get_children():
		piece.set_freeze_enabled(false)
		piece.apply_torque_impulse(Vector3(randf_range(-0.01, 0.01), randf_range(-0.01, 0.01), randf_range(-0.01, 0.01))) 

func free():
	for piece: RigidBody3D in get_children():
		call_deferred("queue_free", piece)
