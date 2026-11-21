extends Node3D

@export var interviewCouch: MeshInstance3D
@export var interviewChair: MeshInstance3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	sceneSetUp()
	gc.sceneCommandLookup = {
		"returnPlayerCamera": returnPlayerCamera,
		"hidePlayer": hidePlayer,
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
		"openStageDoor": openStageDoor
	}
	$Camera3D_OpenOne.set_current(true)
	await gc.fadeIn()
	await get_tree().create_timer(2.0).timeout
	$Camera3D_OpenTwo.set_current(true)
	gc.playDialogFile("res://dialog/script/9_club/34_get_off_boat.json")

func movePlayerToStage():
	$Player.characterBody3D.set_position($stagePlayerTarget.get_position())

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

func returnPlayerCamera():
	$Player.setCameraActive()

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
