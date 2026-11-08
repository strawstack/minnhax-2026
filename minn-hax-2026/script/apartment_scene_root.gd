extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"kitchenCameraA": switchCameraA,
		"kitchenCameraB": switchCameraB,
		"returnPlayerCamera": returnPlayerCamera
	}

func switchCameraA():
	$Cameras/cameraA.set_current(true)

func switchCameraB():
	$Cameras/cameraB.set_current(true)

func returnPlayerCamera():
	$CharacterBody3D/Node3D/Camera3D.set_current(true)
