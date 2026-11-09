extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"cameraSwitchScreen": cameraSwitchScreen,
		"triggerExplosionSound": triggerExplosionSound
	}
	startScene()

func startScene():
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/helicopter/helicopter.json")

func _process(delta: float) -> void:
	pass

func cameraSwitchScreen():
	$Camera3D_SwitchScreen.set_current(true)

func triggerExplosionSound():
	print("TODO: Explosion sound")
	await get_tree().create_timer(1.0).timeout
	gc.endAwaitDialog()
