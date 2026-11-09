extends Node3D

@export var minnMaxLogoStudioDoor: Node3D
@export var minnMaxLogoControlRoom: Node3D

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
		"interviewCameraA": interviewCameraA,
		"interviewCameraB": interviewCameraB,
		"interviewCameraC": interviewCameraC,
		"advanceToMorning": advanceToMorning
	}
	hideInterviewCharacters()

func switchCameraA():
	$Cameras/cameraA.set_current(true)

func switchCameraB():
	$Cameras/cameraB.set_current(true)

func returnPlayerCamera():
	$CharacterBody3D/Node3D/Camera3D.set_current(true)

func revealStudioPrompt():
	minnMaxLogoStudioDoor.set_visible(true)

func hideLeBooBooPreInterview():
	$LeBooBoo.set_visible(false)
	$LeBooBoo.stopFloat()

func revealControlRoomPrompt():
	minnMaxLogoControlRoom.set_visible(true)

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
	# TODO Show stream start prompt in control room
	pass
