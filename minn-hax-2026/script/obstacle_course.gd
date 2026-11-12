extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"playerCanShoot": playerCanShoot,
		"playerCanSkate": playerCanSkate
	}
	startScene()

func startScene():
	$Player.setCameraActive()
	gc.playerCanMove = true
	await gc.fadeIn()

func playerCanShoot():
	$Player.shootingAllowed = true

func playerCanSkate():
	$Player.noSkating = false
	$Player.hideBoard = false

func _process(delta: float) -> void:
	pass
