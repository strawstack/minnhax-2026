extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	startScene()

func startScene():
	await gc.fadeIn()
	print("startScene beach")

func _process(delta: float) -> void:
	pass
