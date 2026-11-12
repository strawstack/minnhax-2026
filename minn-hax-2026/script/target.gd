extends Node3D

@export var targetHitCallbackNode: Node3D

var once = false

func _ready() -> void:
	pass 

func hit():
	$AnimationPlayer.play("down")
	if not once:
		targetHitCallbackNode.targetHit()

func reset():
	$AnimationPlayer.play("up")

func _process(delta: float) -> void:
	pass
