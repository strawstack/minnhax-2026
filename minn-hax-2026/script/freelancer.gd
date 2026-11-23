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
		"returnPlayerCamera": returnPlayerCamera
	}
	$Camera3D_OpenShot.set_current(true)
	$BoatCutscene.set_visible(false)
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/8_freelancer/22_inside_tac_sim.json")

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
	$Boat.set_visible(false)
	$BoatCutscene.set_visible(true)
	$BoatCutscene/Camera3D_Island.set_current(true)
	# TODO play boat engine sound effect
	await get_tree().create_timer(1.0).timeout
	$AnimationPlayer.play("driveBoat")
	$BoatCutscene/Camera3D_House.set_current(true)
	await $AnimationPlayer.animation_finished
	await gc.fadeOut()
	gc.endAwaitDialog()

func _process(delta: float) -> void:
	pass
