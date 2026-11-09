extends Node3D

@export var noFloat: bool

const bounceHeight = 0.25
const duration = 1.0

var tween

func _ready() -> void:
	if not noFloat:
		startFloat()

func startFloat():
	var start_position = position
	tween = create_tween().set_loops()

	tween.tween_property(
		self,
		"position:y",
		start_position.y + bounceHeight,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		self,
		"position:y",
		start_position.y,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func stopFloat():
	if tween:
		tween.kill()
