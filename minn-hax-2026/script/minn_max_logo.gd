extends Node3D

@export var dialogFile: String
@export var configuration: Node3D

var gc

var bounceHeight = 0.25
var rotation_speed = 1.0
var duration = 1.5

func _ready() -> void:
	gc = get_tree().current_scene
	startAnimate()

func startAnimate():
	var start_position = position
	var tween = create_tween().set_loops()

	tween.tween_property(
		self,
		"position:y",
		start_position.y + bounceHeight,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		self,
		"position:y",
		start_position.y - bounceHeight,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func startEvent():
	if dialogFile:
		gc.playDialogFile(dialogFile)
	else:
		configuration.startEvent(self)

func _process(delta: float) -> void:
	rotate_y(rotation_speed * delta)
