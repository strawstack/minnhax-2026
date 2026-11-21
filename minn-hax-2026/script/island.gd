extends Node3D

@export var interviewCouch: MeshInstance3D
@export var interviewChair: MeshInstance3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
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
		"cameraStageClose": cameraStageClose
	}
	$Camera3D_OpenOne.set_current(true)
	await gc.fadeIn()
	await get_tree().create_timer(2.0).timeout
	$Camera3D_OpenTwo.set_current(true)
	gc.playDialogFile("res://dialog/script/9_club/34_get_off_boat.json")

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

func _process(delta: float) -> void:
	pass
