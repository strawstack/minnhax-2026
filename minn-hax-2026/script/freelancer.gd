extends Node3D

var gc
func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"boatToIsland": boatToIsland
	}
	await gc.fadeIn()
	gc.playerCanMove = true

func boatToIsland():
	# TODO boating animation then switch to island scene
	gc.loadIsland()

func _process(delta: float) -> void:
	pass
