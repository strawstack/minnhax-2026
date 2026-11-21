extends Node3D

var canStart

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	$titleScreen/enter_to_start.set_visible(false)
	await gc.fadeIn()
	startScene()

func startScene():
	# TODO audio elevator door open
	$AnimationPlayer.play("elevatorOpen")
	await $AnimationPlayer.animation_finished
	# TODO audio elevator ding
	$titleScreen/enter_to_start.set_visible(true)
	canStart = true

func elevatorClose():
	$AnimationPlayer.play("elevatorClose")
	await $AnimationPlayer.animation_finished
	gc.mainMenuStartPress()

func _process(delta: float) -> void:
	if canStart and Input.is_action_just_pressed("enter"):
		elevatorClose()
