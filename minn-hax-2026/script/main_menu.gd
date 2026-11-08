extends Node3D

var gc
var animationPlayer
var isReady = false

func _ready() -> void:
	gc = get_tree().current_scene
	animationPlayer = $AnimationPlayer
	$CanvasLayer/Label_TheDepartment.set_visible(false)
	$CanvasLayer/Label_title_Of.set_visible(false)
	$CanvasLayer/Label_ParasocialActivity.set_visible(false)
	$CanvasLayer/Label_PressStart.set_visible(false)
	sceneStart()

func sceneStart():
	animationPlayer.play("lebooboo_peek")
	await get_tree().create_timer(4).timeout # Wait for LeBooBoo to hide
	$CanvasLayer/Label_TheDepartment.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	$CanvasLayer/Label_title_Of.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	$CanvasLayer/Label_ParasocialActivity.set_visible(true)
	await get_tree().create_timer(1.0).timeout
	$CanvasLayer/Label_PressStart.set_visible(true)
	isReady = true

func _process(_delta: float) -> void:
	if isReady:
		if Input.is_action_just_pressed("enter"):
			isReady = false
			await gc.mainMenuStartPress() # Note: await will spawn another instance of this _process until scene unmounts
