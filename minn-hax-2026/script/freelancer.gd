extends Node3D

var gc
func _ready() -> void:
	gc = get_tree().current_scene
	await gc.fadeIn()
	gc.playerCanMove = true

func _process(delta: float) -> void:
	pass
