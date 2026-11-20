extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	startScene()

func startScene():
	gc.playerCanMove = true
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/3_beach/12_a_agent_on_beach.json")

func _process(delta: float) -> void:
	pass
