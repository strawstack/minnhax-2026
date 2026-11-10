extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	startScene()

func startScene():
	gc.showCrossHairs(true)
	gc.playerCanMove = true
	await gc.fadeIn()

func _process(delta: float) -> void:
	pass
