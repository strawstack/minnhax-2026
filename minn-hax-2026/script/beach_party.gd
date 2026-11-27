extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"localFadeIn": localFadeIn
	}
	startScene()

func startScene():
	$lebooboos/AnimationPlayer.play("rotate")
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/3_c_beach/13_g_beach_party.json")

func localFadeIn():
	gc.playerCanMove = true
	gc.beachFadeIn()
