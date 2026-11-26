extends Node3D

@export var targetHitCallbackNode: Node3D

var once = false

var gc

func _ready() -> void:
	gc = get_tree().current_scene 

func hit():
	$AnimationPlayer.play("down")
	if not once:
		gc.targetHit()
		if targetHitCallbackNode:
			targetHitCallbackNode.targetHit()

func reset():
	$AnimationPlayer.play("up")

func _process(delta: float) -> void:
	pass
