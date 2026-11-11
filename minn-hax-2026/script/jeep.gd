extends Node3D

var agent
var greenDay

func _ready() -> void:
	agent = $Armature
	greenDay = $Armature_001
	
	agent.set_visible(false)
	greenDay.set_visible(false)

func showPassengers():
	agent.set_visible(true)
	greenDay.set_visible(true)

func _process(delta: float) -> void:
	pass
