extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"cameraSwitchScreen": cameraSwitchScreen,
		"switchLowBatteryAwait": switchLowBatteryAwait,
		"triggerExplosionSound": triggerExplosionSound,
		"waitTwoSeconds": waitTwoSeconds,
		"showLowBattery": showLowBattery
	}
	startScene()

func showLowBattery():
	$Sprite3D_LowBattery.set_visible(true)
	$Sprite3D_Game.set_visible(false)

func waitTwoSeconds():
	await get_tree().create_timer(2.0).timeout
	gc.endAwaitDialog()

func startScene():
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/2_helicopter/11_helicopter_job.json")

func _process(delta: float) -> void:
	pass

func cameraSwitchScreen():
	$Camera3D_SwitchScreen.set_current(true)

func switchLowBatteryAwait():
	await gc.playSoundEffectAwait("low_battery")
	gc.endAwaitDialog()

func triggerExplosionSound():
	gc.playSoundEffect("rocket_fly_explode")
	await get_tree().create_timer(1.0).timeout
	gc.endAwaitDialog()
