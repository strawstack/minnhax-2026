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
	gc.playSoundEffect("elevator_open")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(1.0).timeout
	$titleScreen/enterToStartLabel.set_visible(true)
	canStart = true

func elevatorClose():
	$AnimationPlayer.play("elevatorClose")
	gc.playSoundEffect("elevator_close")
	await $AnimationPlayer.animation_finished
	gc.mainMenuStartPress()

func _process(delta: float) -> void:
	if canStart and Input.is_action_just_pressed("enter"):
		canStart = false
		$titleScreen/enterToStartLabel.set_visible(false)
		elevatorClose()
