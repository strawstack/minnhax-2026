extends Node3D

@export var label: Label

var gc
var animationPlayer
var canStart = false

func _ready() -> void:
	gc = get_tree().current_scene
	animationPlayer = $AnimationPlayer
	await get_tree().create_timer(2).timeout
	canStart = true
	label.set_visible(true)

func startScene():
	$AudioStreamPlayer_Crickets.play()
	await gc.fadeIn()
	animationPlayer.play("float")
	await animationPlayer.animation_finished

	$Camera3D.set_fov(50.0)
	
	animationPlayer.play("slide")
	await animationPlayer.animation_finished

	$AudioStreamPlayer_Boo.play()
	await get_tree().create_timer(1).timeout
	gc.logoSceneEnds()

func _process(_delta: float) -> void:
	if canStart and Input.is_action_just_pressed("enter"):
		canStart = false
		label.set_visible(false)
		startScene()
