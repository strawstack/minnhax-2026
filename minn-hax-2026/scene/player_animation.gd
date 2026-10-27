extends Node3D

func _ready() -> void:
	pass

func setSpeed(speed: float):
	$AnimationPlayer.set_speed_scale(speed)

func playAnimation(name: String):
	$AnimationPlayer.play(name)

func _process(delta: float) -> void:
	pass
