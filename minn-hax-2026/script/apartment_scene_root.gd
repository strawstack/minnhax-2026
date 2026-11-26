extends Node3D

@export var minnMaxLogoStudioDoor: Node3D
@export var minnMaxLogoLeBooBooPreinterview: Node3D
@export var minnMaxLogoControlRoom: Node3D
@export var minnMaxLogoVoiceMail: Node3D
@export var minnMaxLogoControlRoom2: Node3D
@export var richardHeadAnimation: AnimationPlayer
@export var playerCamera: Camera3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"kitchenCameraA": switchCameraA,
		"kitchenCameraB": switchCameraB,
		"returnPlayerCamera": returnPlayerCamera,
		"revealStudioPrompt": revealStudioPrompt,
		"hideLeBooBooPreInterview": hideLeBooBooPreInterview,
		"revealControlRoomPrompt": revealControlRoomPrompt,
		"showInterviewCharacters": showInterviewCharacters,
		"cameraApartmentPlayer": cameraApartmentPlayer,
		"interviewCameraA": interviewCameraA,
		"interviewCameraB": interviewCameraB,
		"interviewCameraC": interviewCameraC,
		"advanceToMorning": advanceToMorning,
		"richardTurnHead": richardTurnHead,
		"richardHeadForward": richardHeadForward,
		"cameraLittleBoo": cameraLittleBoo,
		"openStudioStairsDoor": openStudioStairsDoor,
		"playerFree": playerFree,
		"releaseNevi": releaseNevi,
		"showNeviOnDesk": showNeviOnDesk,
		"silenceNevi": silenceNevi,
		"objectiveA": objectiveA,
		"objectiveB": objectiveB,
		"objectiveC": objectiveC,
		"objectiveD": objectiveD,
		"waitOneSecond": waitOneSecond
	}
	hideInterviewCharacters()
	if gc.DEBUG:
		#minnMaxLogoLeBooBooPreinterview.hideDeactivate()
		#hideLeBooBooPreInterview()
		#advanceToMorning()
		gc.setPlayerCanMove(true)
		gc.showCrossHairs(true)
	else:
		warmUpCameras()

func warmUpCameras():
	playerCamera.set_current(true)
	await get_tree().create_timer(0.5).timeout
	$Cameras/cameraB.set_current(true)
	await get_tree().create_timer(0.5).timeout
	$ZoomCam.set_current(true)
	await get_tree().create_timer(0.5).timeout
	gc.apartmentLoadingDone()
	gc.playBGM("apartment")
	$SubViewport/underwater.continueScene()

func silenceNevi():
	$neviPoints.silence = true

func showNeviOnDesk():
	$neviInterview.set_visible(true)

func playerFree():
	gc.setPlayerCanMove(true)
	gc.showCrossHairs(true)
	gc.showRecording()

func cameraApartmentPlayer():
	playerCamera.set_current(true)

func waitOneSecond():
	await get_tree().create_timer(1.0).timeout
	gc.endAwaitDialog()

func openStudioStairsDoor():
	$studio_door_with_handle_and_open/closedDoor.set_visible(false)
	$studio_door_with_handle_and_open/openDoor.set_visible(true)
	$studio_door_with_handle_and_open/DoorWall/StaticBody3D.set_collision_layer_value(1, false)
	await gc.playSoundEffectAwait("door_open")
	gc.endAwaitDialog()

func closeStudioStairsDoor():
	$studio_door_with_handle_and_open/closedDoor.set_visible(true)
	$studio_door_with_handle_and_open/openDoor.set_visible(false)
	$studio_door_with_handle_and_open/DoorWall/StaticBody3D.set_collision_layer_value(1, true)

func switchCameraA():
	$Cameras/cameraA.set_current(true)

func switchCameraB():
	$Cameras/cameraB.set_current(true)

func returnPlayerCamera():
	$CharacterBody3D/Node3D/Camera3D.set_current(true)

func revealStudioPrompt():
	minnMaxLogoStudioDoor.reveal()

func hideLeBooBooPreInterview():
	$LeBooBoo.set_visible(false)
	$LeBooBoo.stopFloat()
	gc.hideRecording()

func revealControlRoomPrompt():
	minnMaxLogoControlRoom.reveal()

func hideInterviewCharacters():
	$LeBooBooInterview.set_visible(false)
	$MoneyPony.set_visible(false)
	$fortySitting.set_visible(false)

func showInterviewCharacters():
	$LeBooBooInterview.set_visible(true)
	$MoneyPony.set_visible(true)
	$fortySitting.set_visible(true)
	$studioLogos/MinnMax.set_visible(false)
	$studioLogos/leboomax_logo.set_visible(true)

func interviewCameraA():
	$Cameras/Interview/CameraA.set_current(true)

func interviewCameraB():
	$Cameras/Interview/CameraB.set_current(true)

func interviewCameraC():
	$Cameras/Interview/CameraC.set_current(true)

func advanceToMorning():
	# Move player into Weight Room
	$CharacterBody3D.set_position($morningPlayerStart.get_position())
	$CharacterBody3D.rotation.y = PI
	$CharacterBody3D/Node3D.rotation = Vector3(0, 0, 0)
	$CharacterBody3D/Node3D/Camera3D.rotation = Vector3(0, 0, 0)
	hideInterviewCharacters()
	$lilBoo2.set_visible(true)
	$phone.set_visible(true)
	minnMaxLogoVoiceMail.reveal()
	minnMaxLogoControlRoom2.reveal()
	$interviewFeeds.set_visible(false)
	$gameStreamControl.set_visible(true)
	closeStudioStairsDoor()
	gc.setObjectiveLetter("e")

func objectiveA():
	gc.setObjectiveLetter("a")

func objectiveB():
	gc.setObjectiveLetter("b")

func objectiveC():
	gc.setObjectiveLetter("c")

func objectiveD():
	gc.setObjectiveLetter("d")

func richardTurnHead():
	richardHeadAnimation.play("turnHead")

func richardHeadForward():
	$freelancerOnTV.set_visible(true)
	richardHeadAnimation.play("forwardHead")

func releaseNevi():
	$neviPoints.neviCanMove = true

func cameraLittleBoo():
	$Cameras/CameraLittleBoo.set_current(true)
