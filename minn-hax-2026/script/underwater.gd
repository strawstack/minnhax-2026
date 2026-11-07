extends Node3D

@export var agentAnimationPlayer: AnimationPlayer
var gc
var animationPlayer
var lookWatch = false
var startIsReady = false

func _ready() -> void: 
	gc = get_tree().current_scene
	animationPlayer = $AnimationPlayer
	startScene()

func setLookWatch(value):
	lookWatch = value 

func startScene():
	animationPlayer.play("fish_swim")
	await animationPlayer.animation_finished
	animationPlayer.play("float_down")
	await animationPlayer.animation_finished
	if lookWatch:
		await get_tree().create_timer(1.0).timeout
		agentAnimationPlayer.play("LookWatch")
		await agentAnimationPlayer.animation_finished
	await get_tree().create_timer(1.0).timeout
	gc.setPlayerCanMove(true)
	gc.playDialogFile("res://dialog/script/apartment_intro.json")

func _process(_delta: float) -> void:
	pass
