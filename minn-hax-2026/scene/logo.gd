extends Node3D

var gc
var animationPlayer

func _ready() -> void:
	gc = get_tree().current_scene
	animationPlayer = $AnimationPlayer
	startScene()

func startScene():
	animationPlayer.play("float")
	await animationPlayer.animation_finished
	
	$Camera3D.set_fov(50.0)
	
	animationPlayer.play("slide")
	await animationPlayer.animation_finished

	$AudioStreamPlayer_Boo.play()
	await get_tree().create_timer(1).timeout
	gc.logoSceneEnds()

func _process(_delta: float) -> void:
	pass
