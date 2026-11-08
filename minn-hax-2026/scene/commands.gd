extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.commandLookup = {
		"freezePlayer": freezePlayer,
		"unfreezePlayer": unfreezePlayer,
		"objectiveGoSeeComputer": objectiveGoSeeComputer,
		"objectiveStudioDoor": objectiveStudioDoor
	}

func freezePlayer():
	gc.playerCanMove = false

func unfreezePlayer():
	gc.playerCanMove = true

func objectiveGoSeeComputer():
	gc.setObjective("Mouse to look around. WASD to move. Talk to Yu in the kitchen, and visit Richard's office upstairs.")

func objectiveStudioDoor():
	gc.setObjective("Head downstairs to the studio in the basement.")
