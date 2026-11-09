extends Node3D

var agentAnimationPlayer: AnimationPlayer

var gc
var animationPlayer
var startIsReady = false

func _ready() -> void: 
	gc = get_tree().current_scene
	agentAnimationPlayer = $underwater/AnimationPlayer
	if gc.DEBUG:
		if gc.lookWatchUnderwater:
			animationPlayer = $AnimationPlayer
			startScene()
	else:
		animationPlayer = $AnimationPlayer
		startScene()

func startScene():
	animationPlayer.play("fish_swim")
	await animationPlayer.animation_finished
	animationPlayer.play("float_down")
	await animationPlayer.animation_finished
	if gc.lookWatchUnderwater:
		await get_tree().create_timer(1.0).timeout
		agentAnimationPlayer.play("LookWatch")
		await agentAnimationPlayer.animation_finished
	await get_tree().create_timer(1.0).timeout
	if gc.lookWatchUnderwater:
		gc.playDialogFile("res://dialog/script/helicopter/game_intro.json")
	else:
		gc.setPlayerCanMove(true)
		gc.showCrossHairs(true)
		gc.playDialogFile("res://dialog/script/apartment/apartment_intro.json")

func _process(_delta: float) -> void:
	pass
