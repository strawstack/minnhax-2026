extends Node3D

@export var player: CharacterBody3D
var once = false
var gc

func _ready() -> void:
	gc = get_tree().current_scene

func _process(_delta: float) -> void:
	if not once and Input.is_action_just_pressed("enter"):
		if $SubViewport/underwater.startIsReady:
			once = true
			player.canMove = true
			gc.playDialogFile("res://dialog/script/apartment_intro.json")
