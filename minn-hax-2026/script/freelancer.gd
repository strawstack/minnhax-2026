extends Node3D

var gc
func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
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
		"showBoatAndCam": showBoatAndCam,
		"objectiveQ": objectiveQ,
		"objectiveQ2": objectiveQ2,
		"objectiveR": objectiveR,
		"resumeFreelancerBGM": resumeFreelancerBGM
	}
	$Camera3D_OpenShot.set_current(true)
	$BoatCutscene.set_visible(false)
	gc.setObjectiveLetter("n")
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/8_freelancer/22_inside_tac_sim.json")

func resumeFreelancerBGM():
	gc.playBGM("freelancer")

func objectiveQ():
	gc.setObjectiveLetter("q")

func objectiveQ2():
	gc.setObjectiveLetter("q2")

func objectiveR():
	gc.setObjectiveLetter("r")

func hidePlayer():
	$Player.set_visible(false)

func openFridge():
	$AnimationPlayer.play("openFridge")
	gc.setObjectiveLetter("o")

func returnPlayerCamera():
	$Player.setCameraActive()

func revealShooting():
	$minnMaxLogo_shootingRange.reveal()
	$minnMaxLogo_shootingRangeButton.reveal()

func playCollectSound():
	gc.playSoundEffect("success")

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
	gc.setObjectiveLetter("p")

func revealLeaveOnBoat():
	$minnMaxLogo_leaveOnBoat.reveal()

func playBoatAnimation():
	$AnimationPlayer.play("driveBoat")
	gc.playSoundEffect("boat_engine")
	await get_tree().create_timer(3.0).timeout
	gc.loadIsland()

func showBoatAndCam():
	$Boat.set_visible(false)
	$BoatCutscene.set_visible(true)
	$BoatCutscene/Camera3D_House.set_current(true)

func _process(delta: float) -> void:
	pass
