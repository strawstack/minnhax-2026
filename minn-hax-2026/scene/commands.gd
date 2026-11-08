extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.commandLookup = {
		"freezePlayer": freezePlayer,
		"unfreezePlayer": unfreezePlayer
	}

func freezePlayer():
	gc.playerCanMove = false

func unfreezePlayer():
	gc.playerCanMove = true
