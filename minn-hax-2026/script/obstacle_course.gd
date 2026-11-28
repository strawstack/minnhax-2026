extends Node3D

var gc

var commentOnce = false

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"playerCanShoot": playerCanShoot,
		"hideGunModel": hideGunModel,
		"playerCanSkate": playerCanSkate,
		"hideSkateBoardModel": hideSkateBoardModel,
		"hideFlag": hideFlag,
		"revealFlagLogo": revealFlagLogo
	}
	startScene()

func revealFlagLogo():
	$minnMaxLogo_Flag.reveal()

func startScene():
	$Player.setCameraActive()
	gc.showObjective()
	gc.playerCanMove = true
	gc.setObjectiveLetter("k")
	await gc.fadeIn()

func hideGunModel():
	$gun_model.set_visible(false)

func playerCanShoot():
	$Player.shootingAllowed = true

func playerCanSkate():
	$Player.noSkating = false
	$Player.hideBoard = false

func hideSkateBoardModel():
	$SkateBoardBack.set_visible(false)

func hideFlag():
	$red_flag.set_visible(false)
	gc.playSoundEffect("flag_flap")

func _process(delta: float) -> void:
	if not $Player.noSkating and Input.is_action_just_pressed("f_key") and not commentOnce and not gc.dialogInProgress:
		commentOnce = true
		$TimerComment.start()

func _on_timer_comment_timeout() -> void:
	gc.playDialogFile("res://dialog/script/6_obstacle_course/17_c_obstacle_course.json")
