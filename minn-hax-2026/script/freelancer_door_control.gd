extends Node3D

@export var garageSound: bool
@export var slideSound: bool

var once = false
var gc

func _ready() -> void:
	gc = get_tree().current_scene

func _on_body_entered(body: Node3D) -> void:
	if not once:
		once = true
		if garageSound:
			gc.playSoundEffect("garage_door")
		elif slideSound:
			gc.playSoundEffect("elevator_open")
		else:
			gc.playSoundEffect("door_open")
		$AnimationPlayer.play("open")
