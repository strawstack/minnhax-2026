extends Node3D

@export var player: Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
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
		"tacSimStartSound": tacSimStartSound,
		"mSidewaysGlance": mSidewaysGlance,
		"showMEleveator": showMEleveator,
		"closeElevator": closeElevator
	}
	await gc.fadeIn()
	$tac_sim_model/AnimationPlayer.play("open_elevator")
	gc.playerCanMove = true

func showMEleveator():
	$mChars/m_character.set_visible(false)
	$mChars/m_character_elevator.set_visible(true)

func mSidewaysGlance():
	$mChars/m_character.mSidewaysGlance()

func closeElevator():
	await get_tree().create_timer(0.5).timeout
	$tac_sim_model/AnimationPlayer.play("close_elevator")

func hidePlayer():
	$Player.set_visible(false)

func showPlayer():
	$Player.set_visible(true)

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
	$Player.setCameraActive()

func revealBriefing():
	$minnMaxLogo_Talk_MoneyPony.reveal()

func removeBarrier():
	$tacBarrier/StaticBody3D_tacBarrier.set_collision_layer_value(5, false)
	$tacBarrier.set_visible(false)

func tacSimStartSound():
	# TODO play sound, notify dialog on complete
	await get_tree().create_timer(1.0).timeout
	gc.endAwaitDialog()

func _process(delta: float) -> void:
	pass
