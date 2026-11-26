extends Node3D

var agentAnimationPlayer: AnimationPlayer

var gc
var animationPlayer
var startIsReady = false

func _ready() -> void: 
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"continueScene": continueScene
	}
	agentAnimationPlayer = $underwater/AnimationPlayer
	if gc.DEBUG:
		if gc.lookWatchUnderwater:
			animationPlayer = $AnimationPlayer
			startScene()
	else:
		animationPlayer = $AnimationPlayer
		if gc.lookWatchUnderwater:
			startScene()

func startScene():
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/1_underwater/11_a_agent_intro_monologue.json")

func continueScene(): # Called after '11_a_agent_intro_monologue' ends
	if not gc.lookWatchUnderwater:
		await gc.fadeIn()
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
		gc.sceneHelicopter()
	else:
		gc.playDialogFile("res://dialog/script/0_apartment/00_intro.json")

func _process(_delta: float) -> void:
	pass
