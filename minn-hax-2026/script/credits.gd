extends Node3D

var gc

var canPressEnter = false
var onceEnterPress = false

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"slideIn": slideIn,
		"showEnterPrompt": showEnterPrompt
	}
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/9_club/52_final_credits.json")

func showEnterPrompt():
	canPressEnter = true
	$enterPressText.set_visible(true)

func slideIn():
	$AnimationPlayer.play("slideIn")
	await $AnimationPlayer.animation_finished
	gc.endAwaitDialog()

func loadMain():
	await gc.fadeOut()
	gc.mouthLookup.clear()
	gc.loadScene("mainMenu2")

func _process(delta: float) -> void:
	if canPressEnter and not onceEnterPress and Input.is_action_just_pressed("enter"):
		onceEnterPress = true
		loadMain()
