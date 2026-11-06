extends Node3D

var gc
var animationPlayer
var isReady = false

func _ready() -> void:
	gc = get_tree().current_scene
	animationPlayer = $AnimationPlayer
	sceneStart()

func sceneStart():
	await get_tree().create_timer(2.0).timeout
	animationPlayer.play("showStart")
	isReady = true
	await animationPlayer.animation_finished

func startPress():
	$CanvasLayer.set_visible(false)
	gc.mainMenuStartPress()

func _process(delta: float) -> void:
	if isReady:
		if Input.is_action_just_pressed("enter"):
			startPress()
