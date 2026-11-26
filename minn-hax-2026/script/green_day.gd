extends Node3D

@export var agent: Node3D
@export var agent2: Node3D
@export var greenDay: Node3D
@export var returnBlocker: StaticBody3D

var gc
var onceDoorOne = false
var onceDoorTwo = false
var onceDoorThree = false
var onceDoorFour = false
var onceDoorFive = false

var doorAnimationPlayer

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"cameraToPlayer": cameraToPlayer,
		"revealDriveJeep": revealDriveJeep,
		"driveJeep": driveJeep,
		"openDoorOne": openDoorOne,
		"openDoorTwo": openDoorTwo,
		"openDoorThree": openDoorThree,
		"openDoorFour": openDoorFour,
		"openDoorFive": openDoorFive,
		"exitJeep": exitJeep,
		"hideAndFreezeAgentShowIdlePose": hideAndFreezeAgentShowIdlePose,
		"camera3D_AgentToCroissant": camera3D_AgentToCroissant,
		"camera3D_CroissantDuh": camera3D_CroissantDuh,
		"camera3D_MonRoll": camera3D_MonRoll,
		"camera3D_AgentAndOthers": camera3D_AgentAndOthers,
		"switchCameraExitGreenDay": switchCameraExitGreenDay,
		"switchCameraExitAgent": switchCameraExitAgent,
		"exitJeepSceneComplete": exitJeepSceneComplete,
		"startRolling": startRolling,
		"stopRolling": stopRolling
	}
	doorAnimationPlayer = $greenday_training_model/AnimationPlayer
	toggleReturnBlocker(false)
	$fortyIdleNoAnim.set_visible(false)
	startScene()

func toggleReturnBlocker(value: bool):
	returnBlocker.set_collision_layer_value(1, value)

func cameraToPlayer():
	var player = $players.getActive()
	player.setCameraActive()
	$agentPlanePose.set_visible(false)

func startScene():
	$Camera3D.set_current(true)
	gc.setObjectiveLetter("h")
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/4_greenday_training/13_a_intro.json")

func revealDriveJeep():
	$minnMaxLogo_EnterJeep.reveal()
	gc.setObjectiveLetter("i")

func driveJeep():
	agent.set_visible(false)
	gc.playerCanMove = false
	greenDay.set_visible(false)
	$Jeep.showPassengers()
	$Jeep.canDrive = true
	gc.playSoundEffect("car_start")

func startRolling():
	$AnimationPlayerMonRoll.play("roll")

func stopRolling():
	$AnimationPlayerMonRoll.stop()

func openDoorOne():
	gc.playSoundEffect("gear_spin")
	doorAnimationPlayer.play("DoorOne")
func openDoorTwo():
	gc.playSoundEffect("gear_spin")
	doorAnimationPlayer.play("DoorTwo")
func openDoorThree():
	gc.playSoundEffect("gear_spin")
	doorAnimationPlayer.play("DoorThree")
func openDoorFour():
	gc.playSoundEffect("gear_spin")
	doorAnimationPlayer.play("DoorFour")
func openDoorFive():
	gc.playSoundEffect("gear_spin")
	doorAnimationPlayer.play("DoorFive")

func _process(delta: float) -> void:
	pass

func doorOne():
	if not onceDoorOne:
		onceDoorOne = true
		gc.playDialogFile("res://dialog/script/4_greenday_training/14_c_prior_door_two.json")
func _on_pass_door_one_area_entered(area: Area3D) -> void:
	doorOne()
func _on_pass_door_one_body_entered(body: Node3D) -> void:
	doorOne()

func doorTwo():
	if not onceDoorTwo:
		onceDoorTwo = true
		gc.playDialogFile("res://dialog/script/4_greenday_training/14_d_prior_door_three.json")
func _on_pass_door_two_area_entered(area: Area3D) -> void:
	doorTwo()
func _on_pass_door_two_body_entered(body: Node3D) -> void:
	doorTwo()

func doorThree():
	if not onceDoorThree:
			onceDoorThree = true
			gc.playDialogFile("res://dialog/script/4_greenday_training/14_e_prior_door_four.json")
func _on_pass_door_three_area_entered(area: Area3D) -> void:
	doorThree()
func _on_pass_door_three_body_entered(body: Node3D) -> void:
	doorThree()

func doorFour():
	if not onceDoorFour:
		onceDoorFour = true
		gc.playDialogFile("res://dialog/script/4_greenday_training/14_f_prior_door_five.json")
func _on_pass_door_four_area_entered(area: Area3D) -> void:
	doorFour()
func _on_pass_door_four_body_entered(body: Node3D) -> void:
	doorFour()

func doorFive():
	if not onceDoorFive:
		onceDoorFive = true
		toggleReturnBlocker(true)
		gc.playDialogFile("res://dialog/script/4_greenday_training/14_g_exit_jeep.json")
func _on_pass_door_five_area_entered(area: Area3D) -> void:
	doorFive()
func _on_pass_door_five_body_entered(body: Node3D) -> void:
	doorFive()

func exitJeep():
	$Jeep.canDrive = false
	$Jeep.set_visible(false)
	$JeepParkScene.set_visible(true)
	agent.localFreeze = true
	agent2.resetCamera()

func switchCameraExitGreenDay():
	$JeepParkScene/Camera3D_GreenDay.set_current(true)

func switchCameraExitAgent():
	$JeepParkScene/Camera3D_Agent.set_current(true)

func exitJeepSceneComplete():
	$JeepParkScene/fortyIdleNoAnim2.set_visible(false)
	agent2.set_visible(true)
	agent2.setCameraActive()
	agent2.localFreeze = false
	gc.playerCanMove = true
	gc.showObjective()

func hideAndFreezeAgentShowIdlePose():
	gc.playerCanMove = false
	agent.set_visible(false)
	agent2.set_visible(false)
	$fortyIdleNoAnim.set_visible(true)

func camera3D_AgentToCroissant():
	$Camera3D_AgentToCroissant.set_current(true)

func camera3D_CroissantDuh():
	$Camera3D_CroissantDuh.set_current(true)

func camera3D_MonRoll():
	$Camera3D_MonRoll.set_current(true)

func camera3D_AgentAndOthers():
	$Camera3D_AgentAndOthers.set_current(true)
