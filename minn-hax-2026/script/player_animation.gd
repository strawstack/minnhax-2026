extends Node3D

@export var head: MeshInstance3D
@export var mouth: Node3D

func _ready() -> void:
	pass

func setSpeed(speed: float):
	$AnimationPlayer.set_speed_scale(speed)

func playAnimation(name: String):
	$AnimationPlayer.play(name)

func hideHead(value: bool):
	head.set_visible(not value)
	mouth.set_visible(not value)

func _process(delta: float) -> void:
	pass
