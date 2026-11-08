extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene

func startEvent(logoRef: Node3D):
	logoRef.set_visible(false)

func _process(_delta: float) -> void:
	pass
