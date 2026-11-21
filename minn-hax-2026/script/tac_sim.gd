extends Node3D

@export var player: Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.gc.sceneCommandLookup = {
		"showPlayer": showPlayer,
		"hidePlayer": hidePlayer,
		"showFortyMTalk": showFortyMTalk,
		"hideFortyMTalk": hideFortyMTalk,
		"camera3D_M": camera3D_M,
		"camera3D_M_Close": camera3D_M_Close,
		"camera3D_GreenDay": camera3D_GreenDay,
		"camera3D_Agent": camera3D_Agent,
		"returnPlayerCamera": returnPlayerCamera,
		"revealBriefing": revealBriefing,
		"removeBarrier": removeBarrier,
		"tacSimStartSound": tacSimStartSound
	}
	await gc.fadeIn()
	$tac_sim_model/AnimationPlayer.play("open_elevator")
	gc.playerCanMove = true

func hidePlayer():
	$player.set_visible(false)

func showPlayer():
	$player.set_visible(true)

func showFortyMTalk():
	$fortyMTalk.set_visible(true)

func hideFortyMTalk():
	$fortyMTalk.set_visible(false)

func camera3D_M():
	$mTalkCams/Camera3D_M.set_current(true)

func camera3D_M_Close():
	$mTalkCams/Camera3D_M_Close.set_current(true)

func camera3D_GreenDay():
	$mTalkCams/Camera3D_GreenDay.set_current(true)

func camera3D_Agent():
	$mTalkCams/Camera3D_Agent.set_current(true)

func returnPlayerCamera():
	$player.setCameraActive()

func revealBriefing():
	$minnMaxLogo_Talk_MoneyPony.reveal()

func removeBarrier():
	$tacBarrier/StaticBody3D_tacBarrier.set_collision_layer_value(5, false)
	$tacBarrier.set_visible(false)

func tacSimStartSound():
	# TODO play sound, notify dialog on complete
	pass

func _process(delta: float) -> void:
	pass
