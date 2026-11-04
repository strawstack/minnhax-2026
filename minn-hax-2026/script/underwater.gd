extends Node3D

@export var animationPlayer: AnimationPlayer
@export var agentAnimationPlayer: AnimationPlayer
@export var startLabel: Label

var startIsReady = false

func _ready() -> void:
	startLabel.set_modulate(Color(1,1,1,0)) 
	startScene()

func startScene():
	animationPlayer.play("drift_down")
	await animationPlayer.animation_finished
	
	await get_tree().create_timer(1.0).timeout
	
	agentAnimationPlayer.play("LookWatch")
	await agentAnimationPlayer.animation_finished
	
	startIsReady = true
	
	animationPlayer.play("show_start_label")
	await animationPlayer.animation_finished

# TODO(richard): in _process allow player to press start after startScene completes
# Pressing start will trigger Agent to look at watch then the outer scene will free the camera
# and Richard will talk to the player

func _process(delta: float) -> void:
	pass
