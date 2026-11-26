extends Node3D

@export var animationPlayer_Cowbell: AnimationPlayer

var gc

var once_setObjectiveX = false
var canPlayCowbell = false

const soundEffect = {
	"glass": preload("res://audio/soundEffect/glass_break.mp3"),
	"needle": preload("res://audio/soundEffect/tatto_needle.mp3")
}

func _ready() -> void:
	gc = get_tree().current_scene
	sceneSetUp()
	gc.sceneCommandLookup = {
		"returnPlayer1Camera": returnPlayer1Camera,
		"returnPlayer2Camera": returnPlayer2Camera,
		"returnPlayer3Camera": returnPlayer3Camera,
		"hidePlayer1": hidePlayer1,
		"showPlayer1": showPlayer1,
		"hidePlayer2": hidePlayer2,
		"showPlayer2": showPlayer2,
		"hidePlayer3": hidePlayer3,
		"showPlayer3": showPlayer3,
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
		"switchToPlayer3": switchToPlayer3,
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
		"tattooSoundEffectAndFadeIn": tattooSoundEffectAndFadeIn,
		"cameraCloseTattoo": cameraCloseTattoo,
		"cameraLeBooBoo": cameraLeBooBoo,
		"cameraArtist": cameraArtist,
		"cameraPullBack": cameraPullBack,
		"waitOneSecond": waitOneSecond,
		"waitTwoSeconds": waitTwoSeconds,
		"freeShards": freeShards,
		"hideTattooScene": hideTattooScene,
		"cameraLady": cameraLady,
		"showIdleAtLady": showIdleAtLady,
		"hideIdleAtLady": hideIdleAtLady,
		"turnLady": turnLady,
		"forwardLady": forwardLady,
		"revealMinnMaxLogo_TCBBar": revealMinnMaxLogo_TCBBar,
		"revealMinnMaxLogo_HostMeetup": revealMinnMaxLogo_HostMeetup,
		"showFortyIdleNoAnimDrummer": showFortyIdleNoAnimDrummer,
		"hideFortyIdleNoAnimDrummer": hideFortyIdleNoAnimDrummer,
		"startRockCatAnimation": startRockCatAnimation,
		"stopRockCatAnimation": stopRockCatAnimation,
		"cameraSeeCat": cameraSeeCat,
		"cameraSeeInterviewer": cameraSeeInterviewer,
		"cameraSeeLeBooBoo": cameraSeeLeBooBoo,
		"cameraSeePullBack": cameraSeePullBack,
		"hideOutsideTCB": hideOutsideTCB,
		"revealMinnMaxLogo_CenterDanceFloor": revealMinnMaxLogo_CenterDanceFloor,
		"cameraPostLeBooBoo": cameraPostLeBooBoo,
		"cameraPostAgent": cameraPostAgent,
		"showSpyExitSign": showSpyExitSign,
		"hideDJ": hideDJ,
		"hideIdlePostShowAgent": hideIdlePostShowAgent,
		"revealMinnMaxLogo_CreditsExit": revealMinnMaxLogo_CreditsExit,
		"objectiveT": objectiveT,
		"objectiveW": objectiveW,
		"allowPlayCowbell": allowPlayCowbell,
		"stopPlayCowbell": stopPlayCowbell
	}
	# Make sure these nodes are hidden on start
	$players/Player2.set_visible(false)
	$players/Player3.set_visible(false)
	$sceneTattoo/fortyIdleNoAnimRoof.set_visible(false)
	$tcbCharacterAtBar.set_visible(false)
	$Camera3D_OpenTwo.set_current(true)
	gc.setObjectiveLetter("s")
	await gc.fadeIn()
	if gc.DEBUG:
		switchToPlayer2()
		gc.playerCanMove = true
	else:
		gc.playDialogFile("res://dialog/script/9_club/34_get_off_boat.json")

func allowPlayCowbell():
	canPlayCowbell = true

func stopPlayCowbell():
	canPlayCowbell = false

func objectiveW():
	gc.setObjectiveLetter("w")

func objectiveT():
	gc.setObjectiveLetter("t")

func revealMinnMaxLogo_CreditsExit():
	$logoPoints/minnMaxLogo_CreditsExit.reveal()

func hideIdlePostShowAgent():
	$postShowTalk/fortyIdleNoAnim.set_visible(false)

func hideDJ():
	$club_dj.set_visible(false)

func showSpyExitSign():
	$spyExit.set_visible(true)

func cameraPostLeBooBoo():
	$postShowTalk/PostLeBooBoo.set_current(true)

func cameraPostAgent():
	$postShowTalk/PostAgent.set_current(true)

func revealMinnMaxLogo_CenterDanceFloor():
	$logoPoints/minnMaxLogo_CenterDanceFloor.reveal()
	gc.setObjectiveLetter("v")

func hideOutsideTCB():
	$sceneTalkToTCB/tcbCharacter.set_visible(false)

func cameraSeeCat():
	$sceneSeeEverything/SeeCat.set_current(true)

func cameraSeeInterviewer():
	$sceneSeeEverything/SeeInterviewer.set_current(true)

func cameraSeeLeBooBoo():
	$sceneSeeEverything/SeeLeBooBoo.set_current(true)

func cameraSeePullBack():
	$sceneSeeEverything/SeePullBack.set_current(true)

func startRockCatAnimation():
	$sceneSeeEverything/AnimationPlayer.play("rockCat")

func stopRockCatAnimation():
	$sceneSeeEverything/AnimationPlayer.stop()

func showFortyIdleNoAnimDrummer():
	$sceneDrummerDistract/fortyIdleNoAnimDrummer.set_visible(true)

func hideFortyIdleNoAnimDrummer():
	$sceneDrummerDistract/fortyIdleNoAnimDrummer.set_visible(false)

func revealMinnMaxLogo_HostMeetup():
	$logoPoints/minnMaxLogo_HostMeetup.reveal()
	gc.setObjectiveLetter("u")

func revealMinnMaxLogo_TCBBar():
	$logoPoints/minnMaxLogo_TCBBar.reveal()
	$tcbCharacterAtBar.set_visible(true)

func turnLady():
	$sceneRedDress/LadyDress/AnimationPlayer.play("turn")
	await $sceneRedDress/LadyDress/AnimationPlayer.animation_finished
	gc.endAwaitDialog()

func forwardLady():
	$sceneRedDress/LadyDress/AnimationPlayer.play("forward")

func showIdleAtLady():
	$sceneRedDress/fortyIdleNoAnimRed.set_visible(true)

func hideIdleAtLady():
	$sceneRedDress/fortyIdleNoAnimRed.set_visible(false)

func cameraLady():
	$sceneRedDress/Lady.set_current(true)

func hideTattooScene():
	$tattooCharacters.set_visible(false)

func playSoundEffectAwait(soundName: String):
	$audio/AudioStreamPlayerSoundEffect.stop()
	$audio/AudioStreamPlayerSoundEffect.stream = soundEffect[soundName]
	$audio/AudioStreamPlayerSoundEffect.play()
	await $audio/AudioStreamPlayerSoundEffect.finished

func playSoundEffect(soundName: String):
	$audio/AudioStreamPlayerSoundEffect.stop()
	$audio/AudioStreamPlayerSoundEffect.stream = soundEffect[soundName]
	$audio/AudioStreamPlayerSoundEffect.play()

func playerFallAnimationSequence():
	showfortyIdleNoAnimRoof()
	$sceneTattoo/AnimationPlayer.play("playerFall")
	$glass_shards.fall()
	gc.playSoundEffect("glass_break")
	await $sceneTattoo/AnimationPlayer.animation_finished
	gc.endAwaitDialog()

func freeShards():
	$glass_shards.free()

func breakGlassSoundEffect():
	await gc.playSoundEffectAwait("glass_break")
	gc.endAwaitDialog()

func tattooSoundEffectAndFadeIn():
	gc.fadeIn()
	await gc.playSoundEffectAwait("tattoo_needle")
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

func waitTwoSeconds():
	await get_tree().create_timer(2.0).timeout
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

func hidePlayer2():
	$players/Player2.set_visible(false)

func showPlayer2():
	$players/Player2.set_visible(true)

func hidePlayer3():
	$players/Player3.set_visible(false)

func showPlayer3():
	$players/Player3.set_visible(true)

func switchToPlayer2():
	gc.setObjectiveLetter("s2")
	$players/Player.localFreeze = true
	$players/Player.set_visible(false)
	$players/Player2.localFreeze = false
	$players/Player2.set_visible(true)
	$players/Player2.setCameraActive()
	gc.playBGM("insideclub")

func switchToPlayer3():
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
	$playCowBellInstruction.set_visible(false)
	$club_dj.set_visible(false) # Just in case
	$club_dj_mic.set_visible(false)
	$postShowTalk.set_visible(true)

func showLeBooBooAtMic():
	$LeBooBoo.set_visible(true)

func showCrabPerformance():
	# NOTE no longer used
	$LeBooBoo.set_visible(false)
	$club_dj.set_visible(false)
	$club_dj_mic.set_visible(true)
	$cowBellGuy.set_visible(true)

func showLeBooBooPerformance():
	$club_dj.set_visible(false)
	$cowBellGuy.set_visible(true)
	$playCowBellInstruction.set_visible(true)

func cameraStageCrowd():
	$Cameras/StageCrowd.set_current(true)

func cameraStageClose():
	$Cameras/StageClose.set_current(true)

func hideInterviewScene():
	$logoPoints/minnMaxLogo_Interview.hideDeactivate()
	$sceneSeeEverything/interview_scene/interview_couch/StaticBody3D.set_collision_layer_value(1, false)
	$sceneSeeEverything/interview_scene/interview_chair/StaticBody3D.set_collision_layer_value(1, false)
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
	if canPlayCowbell and Input.is_action_just_pressed("jump"):
		animationPlayer_Cowbell.play("cowbell")
		gc.playCowbell()

func _on_area_3d_final_exit_body_entered(body: Node3D) -> void:
	if not once_setObjectiveX:
		once_setObjectiveX = true
		gc.setObjectiveLetter("x")
