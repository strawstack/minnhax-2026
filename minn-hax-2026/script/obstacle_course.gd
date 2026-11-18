extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"playerCanShoot": playerCanShoot,
		"hideGunModel": hideGunModel,
		"playerCanSkate": playerCanSkate,
		"hideSkateBoardModel": hideSkateBoardModel
	}
	startScene()

func startScene():
	$Player.setCameraActive()
	gc.playerCanMove = true
	await gc.fadeIn()

func hideGunModel():
	$gun_model.set_visible(false)

func playerCanShoot():
	$Player.shootingAllowed = true

func playerCanSkate():
	$Player.noSkating = false
	$Player.hideBoard = false

func hideSkateBoardModel():
	$SkateBoardBack.set_visible(false)

func _process(delta: float) -> void:
	pass
