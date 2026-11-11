extends Node3D

@export var agent: Node3D
@export var greenDay: Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"cameraToPlayer": cameraToPlayer,
		"revealDriveJeep": revealDriveJeep,
		"driveJeep": driveJeep
	}
	startScene()

func cameraToPlayer():
	$Player.setCameraActive()

func startScene():
	$Camera3D.set_current(true)
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/greenday/intro.json")

func revealDriveJeep():
	$minnMaxLogo_EnterJeep.reveal()

func driveJeep():
	agent.set_visible(false)
	greenDay.set_visible(false)
	$Jeep.showPassengers()
	gc.playerCanMove = false

func _process(delta: float) -> void:
	pass
