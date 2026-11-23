extends Node3D

var gc
func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"boatToIsland": boatToIsland,
		"openShootingDoorAndBars": openShootingDoorAndBars,
		"pickUpBoard": pickUpBoard,
		"playerCanSkate": playerCanSkate,
		"openParkDoor": openParkDoor,
		"collectSkateSecretTape": playCollectSound,
		"collectShootingSecretTape": playCollectSound,
		"openShootingExitDoor": openShootingExitDoor,
		"revealLeaveOnBoat": revealLeaveOnBoat,
		"playBoatAnimation": playBoatAnimation,
		"revealShooting": revealShooting,
		"returnPlayerCamera": returnPlayerCamera,
		"openFridge": openFridge,
		"hidePlayer": hidePlayer,
		"showBoatAndCam": showBoatAndCam 
	}
	$Camera3D_OpenShot.set_current(true)
	$BoatCutscene.set_visible(false)
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/8_freelancer/22_inside_tac_sim.json")

func hidePlayer():
	$Player.set_visible(false)

func openFridge():
	$AnimationPlayer.play("openFridge")

func returnPlayerCamera():
	$Player.setCameraActive()

func revealShooting():
	$minnMaxLogo_shootingRange.reveal()
	$minnMaxLogo_shootingRangeButton.reveal()

func boatToIsland():
	# TODO boating animation then switch to island scene
	gc.loadIsland()

func playCollectSound():
	# TODO play collect sound
	pass

func openShootingDoorAndBars():
	$AnimationPlayer.play("shootingDoorAndCageOpen")

func openShootingExitDoor():
	$AnimationPlayer.play("openShootingExitDoor")

func pickUpBoard():
	$SkateBoardBack.set_visible(false)

func playerCanSkate():
	$Player.noSkating = false
	$Player.showBoard(true)

func openParkDoor():
	$AnimationPlayer.play("openSkateParkDoor")

func revealLeaveOnBoat():
	$minnMaxLogo_leaveOnBoat.reveal()

func playBoatAnimation():
	# TODO play boat engine sound effect
	$AnimationPlayer.play("driveBoat")
	await get_tree().create_timer(3.0).timeout
	gc.loadIsland()

func showBoatAndCam():
	$Boat.set_visible(false)
	$BoatCutscene.set_visible(true)
	$BoatCutscene/Camera3D_House.set_current(true)

func _process(delta: float) -> void:
	pass
