extends Node3D

var gc

var targetCount = 0
var onceTrigger = false

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"returnPlayerControl": returnPlayerControl
	}
	$Player.set_visible(false)
	$Camera3D_MonRoll.set_current(true)
	await gc.fadeIn()
	startScene()

func startScene():
	gc.setObjectiveLetter("j")
	gc.playDialogFile("res://dialog/script/5_target_shooting/16_a_target_shoot_before.json")

func targetHit():
	targetCount += 1
	if targetCount == 3:
		if not onceTrigger:
			onceTrigger = true
			$Timer.start()

func returnPlayerControl():
	$fortyIdleNoAnim.set_visible(false)
	gc.playerCanMove = true
	$Player.setCameraActive()
	$Player.set_visible(true)

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	gc.playerCanMove = false
	$Player.set_visible(false)
	$fortyIdleNoAnim.set_visible(true)
	$Camera3D_MonRoll.set_current(true)
	gc.playDialogFile("res://dialog/script/5_target_shooting/16_b_target_shoot_after.json")
