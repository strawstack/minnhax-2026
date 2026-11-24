extends Node3D

@export var interviewCouch: MeshInstance3D
@export var interviewChair: MeshInstance3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	sceneSetUp()
	gc.sceneCommandLookup = {
		"returnPlayer1Camera": returnPlayer1Camera,
		"hidePlayer1": hidePlayer1,
		"showPlayer1": showPlayer1,
		"hideIdleAtBouncer": hideIdleAtBouncer,
		"showPlayer": showPlayer,
		"cameraTCB": cameraTCB,
		"cameraAgentAtTCB": cameraAgentAtTCB,
		"cameraMeetupRoom": cameraMeetupRoom,
		"cameraDrummerMeetup": cameraDrummerMeetup,
		"meetupDoorOpen": meetupDoorOpen,
		"meetupDoorClose": meetupDoorClose,
		"showMeetupSign": showMeetupSign,
		"drummerInRoom": drummerInRoom,
		"hideInterviewScene": hideInterviewScene,
		"cameraStageCrowd": cameraStageCrowd,
		"cameraStageClose": cameraStageClose,
		"showLeBooBooAtMic": showLeBooBooAtMic,
		"showCrabPerformance": showCrabPerformance,
		"showLeBooBooPerformance": showLeBooBooPerformance,
		"setPostShowTalk": setPostShowTalk,
		"movePlayerToStage": movePlayerToStage,
		"activateStageWalls": activateStageWalls,
		"openStageDoor": openStageDoor,
		"switchToPlayer2": switchToPlayer2,
		"showIdleAtBouncer": showIdleAtBouncer,
		"showLabel3D_RampTruck": showLabel3D_RampTruck,
		"revealMinnMaxLogo_RampAnnounce": revealMinnMaxLogo_RampAnnounce,
		"revealMinnMaxLogo_TouchRamps": revealMinnMaxLogo_TouchRamps,
		"hideFortyIdleNoAnimRamp": hideFortyIdleNoAnimRamp,
		"showFortyIdleNoAnimRamp": showFortyIdleNoAnimRamp,
		"cameraAgent": cameraAgent,
		"cameraRampGuy": cameraRampGuy,
		"showfortyIdleNoAnimRoof": showfortyIdleNoAnimRoof,
		"hidefortyIdleNoAnimRoof": hidefortyIdleNoAnimRoof,
		"playerFallAnimationSequence": playerFallAnimationSequence,
		"breakGlassSoundEffect": breakGlassSoundEffect,
		"tattooSoundEffect": tattooSoundEffect,
		"cameraCloseTattoo": cameraCloseTattoo,
		"cameraLeBooBoo": cameraLeBooBoo,
		"cameraArtist": cameraArtist,
		"cameraPullBack": cameraPullBack,
		"waitOneSecond": waitOneSecond,
		"waitThreeSeconds": waitThreeSeconds,
		"freeShards": freeShards
	}
	# Make sure these nodes are hidden on start
	$players/Player2.set_visible(false)
	$players/Player3.set_visible(false)
	$sceneTattoo/fortyIdleNoAnimRoof.set_visible(false)
	
	$Camera3D_OpenTwo.set_current(true)
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/9_club/34_get_off_boat.json")

func playerFallAnimationSequence():
	showfortyIdleNoAnimRoof()
	$sceneTattoo/AnimationPlayer.play("playerFall")
	$glass_shards.fall()
	await $sceneTattoo/AnimationPlayer.animation_finished
	gc.endAwaitDialog()

func freeShards():
	$glass_shards.free()

func breakGlassSoundEffect():
	# TODO play sound
	await get_tree().create_timer(1.0).timeout
	gc.endAwaitDialog()

func tattooSoundEffect():
	# TODO play sound
	await get_tree().create_timer(1.0).timeout
	gc.endAwaitDialog()

func cameraCloseTattoo():
	$sceneTattoo/CloseTattoo.set_current(true)

func cameraLeBooBoo():
	$sceneTattoo/LeBooBoo.set_current(true)

func cameraArtist():
	$sceneTattoo/Artist.set_current(true)

func cameraPullBack():
	$sceneTattoo/PullBack.set_current(true)

func waitOneSecond():
	await get_tree().create_timer(1.0).timeout
	gc.endAwaitDialog()

func waitThreeSeconds():
	await get_tree().create_timer(3.0).timeout
	gc.endAwaitDialog()

func showfortyIdleNoAnimRoof():
	$sceneTattoo/fortyIdleNoAnimRoof.set_visible(true)

func hidefortyIdleNoAnimRoof():
	$sceneTattoo/fortyIdleNoAnimRoof.set_visible(false)

func cameraAgent():
	$sceneRampGuy/Agent.set_current(true)

func cameraRampGuy():
	$sceneRampGuy/RampGuy.set_current(true)

func showFortyIdleNoAnimRamp():
	$sceneRampGuy/fortyIdleNoAnimRamp.set_visible(true)

func hideFortyIdleNoAnimRamp():
	$sceneRampGuy/fortyIdleNoAnimRamp.set_visible(false)

func revealMinnMaxLogo_RampAnnounce():
	$logoPoints/minnMaxLogo_RampAnnounce.reveal()

func revealMinnMaxLogo_TouchRamps():
	$logoPoints/minnMaxLogo_TouchRamps.reveal()
	$logoPoints/minnMaxLogo_Window.reveal()

func showLabel3D_RampTruck():
	$Label3D_RampTruck.set_visible(true)

func showIdleAtBouncer():
	$sceneTalkToTCB/fortyIdleNoAnim.set_visible(true)

func hideIdleAtBouncer():
	$sceneTalkToTCB/fortyIdleNoAnim.set_visible(false)

func hidePlayer1():
	$players/Player.set_visible(false)

func showPlayer1():
	$players/Player.set_visible(true)

func switchToPlayer2():
	$players/Player.localFreeze = true
	$players/Player.set_visible(false)
	$players/Player2.localFreeze = false
	$players/Player2.set_visible(true)
	$players/Player2.setCameraActive()

func movePlayerToStage():
	$players/Player2.localFreeze = true
	$players/Player2.set_visible(false)
	$players/Player3.localFreeze = false
	$players/Player3.set_visible(true)
	$players/Player3.setCameraActive()

func activateStageWalls():
	$stageWalls.activateWalls(true)

func sceneSetUp():
	$club_dj.set_visible(true)
	$LeBooBoo.set_visible(false)
	$cowBellGuy.set_visible(false)
	$club_dj_mic.set_visible(false)
	$postShowTalk.set_visible(false)
	$sceneDrummerDistract/FakeMeetupSign.set_visible(false)
	$sceneDrummerDistract/DrummerCharacterInRoom.set_visible(false)

func setPostShowTalk():
	$LeBooBoo.set_visible(false)
	$cowBellGuy.set_visible(false)
	$club_dj.set_visible(false)
	$club_dj_mic.set_visible(false)

func showLeBooBooAtMic():
	$LeBooBoo.set_visible(true)

func showCrabPerformance():
	$LeBooBoo.set_visible(false)
	$club_dj.set_visible(false)
	$club_dj_mic.set_visible(true)
	$cowBellGuy.set_visible(true)

func showLeBooBooPerformance():
	$LeBooBoo.set_visible(true)
	$club_dj_mic.set_visible(false)
	$cowBellGuy.set_visible(true)

func cameraStageCrowd():
	$Cameras/StageCrowd.set_current(true)

func cameraStageClose():
	$Cameras/StageClose.set_current(true)

func hideInterviewScene():
	interviewCouch.get_node("StaticBody3D").set_collision_layer(1, false)
	interviewChair.get_node("StaticBody3D").set_collision_layer(1, false)
	$sceneSeeEverything.set_visible(false)

func meetupDoorOpen():
	$sceneDrummerDistract/AnimationPlayer.play("meetupDoorOpen")

func meetupDoorClose():
	$sceneDrummerDistract/AnimationPlayer.play("meetupDoorClose")

func showMeetupSign():
	$sceneDrummerDistract/FakeMeetupSign.set_visible(true)

func drummerInRoom():
	$sceneDrummerDistract/DrummerCharacter.set_visible(false)
	$sceneDrummerDistract/DrummerCharacterInRoom.set_visible(true)

func returnPlayer1Camera():
	$players/Player.setCameraActive()

func returnPlayer2Camera():
	$players/Player2.setCameraActive()

func returnPlayer3Camera():
	$players/Player3.setCameraActive()

func cameraMeetupRoom():
	$sceneDrummerDistract/Room.set_current(true)

func cameraDrummerMeetup():
	$sceneDrummerDistract/Drummer.set_current(true)

func hidePlayer():
	$Player.set_visible(false)

func showPlayer():
	$Player.set_visible(true)

func cameraTCB():
	$sceneTalkToTCB/TCB.set_current(true)

func cameraAgentAtTCB():
	$sceneTalkToTCB/AgentAtTCB.set_current(true)

func openStageDoor():
	$backStageDoor/AnimationPlayer.play("openStageDoor")

func _process(delta: float) -> void:
	pass
