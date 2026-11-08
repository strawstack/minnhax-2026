extends Node3D

@export var prompt: String
@export var dialogFile: String
@export var configuration: String

var gc

var bounceHeight = 0.25
var rotation_speed = 1.0
var duration = 1.5

var eventTriggered = false

var meshInstance3DGlow
var original
var originalSecond
var deactive
var deactiveSecond

func _ready() -> void:
	gc = get_tree().current_scene
	meshInstance3DGlow = $MeshInstance3D_Glow
	original = $Arrows/Original
	originalSecond = $Arrows/OriginalSecond
	deactive = $Arrows/Deactive
	deactiveSecond = $Arrows/DeactiveSecond
	startAnimate()

func showInteract():
	if not eventTriggered:
		if gc.dialogInProgress:
			gc.showInteract("Event not available during dialog")
		else:
			gc.showInteract("Press 'E' to " + prompt)

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
	eventTriggered = true
	set_visible(false)
	gc.hideInteract()
	if dialogFile:
		gc.playDialogFile(dialogFile)
	else:
		gc.startEvent(configuration)

func _process(delta: float) -> void:
	rotate_y(rotation_speed * delta)
	meshInstance3DGlow.set_visible(not gc.dialogInProgress)
	original.set_visible(not gc.dialogInProgress)
	originalSecond.set_visible(not gc.dialogInProgress)
	deactive.set_visible(gc.dialogInProgress)
	deactiveSecond.set_visible(gc.dialogInProgress)
