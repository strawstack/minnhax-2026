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
		"camera75fov": camera75fov,
		"interviewCameraA": interviewCameraA,
		"interviewCameraB": interviewCameraB,
		"interviewCameraC": interviewCameraC,
		"advanceToMorning": advanceToMorning,
		"richardTurnHead": richardTurnHead,
		"richardHeadForward": richardHeadForward,
		"cameraLittleBoo": cameraLittleBoo,
		"openStudioStairsDoor": openStudioStairsDoor,
		"playerFree": playerFree,
		"releaseNevi": releaseNevi
	}
	hideInterviewCharacters()
	if gc.DEBUG:
		#minnMaxLogoLeBooBooPreinterview.hideDeactivate()
		#hideLeBooBooPreInterview()
		#advanceToMorning()
		gc.setPlayerCanMove(true)
		gc.showCrossHairs(true)

func playerFree():
	gc.setPlayerCanMove(true)
	gc.showCrossHairs(true)

func camera75fov():
	playerCamera.set_fov(75.0)

func openStudioStairsDoor():
	$studio_door_with_handle_and_open/closedDoor.set_visible(false)
	$studio_door_with_handle_and_open/openDoor.set_visible(true)
	$studio_door_with_handle_and_open/DoorWall/StaticBody3D.set_collision_layer_value(1, false)

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
	# TODO Show phone on table
	minnMaxLogoVoiceMail.reveal()
	# TODO Show stream start prompt in control room
	minnMaxLogoControlRoom2.reveal()

func richardTurnHead():
	richardHeadAnimation.play("turnHead")

func richardHeadForward():
	$freelancerOnTV.set_visible(true)
	richardHeadAnimation.play("forwardHead")

func releaseNevi():
	$neviPoints.neviCanMove = true

func cameraLittleBoo():
	$Cameras/CameraLittleBoo.set_current(true)
