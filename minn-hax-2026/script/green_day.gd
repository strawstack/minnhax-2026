extends Node3D

@export var agent: Node3D
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
		"camera3D_AgentToCroissant": camera3D_AgentToCroissant
	}
	doorAnimationPlayer = $greenday_training_model/AnimationPlayer
	toggleReturnBlocker(false)
	$fortyIdleNoAnim.set_visible(false)
	startScene()

func toggleReturnBlocker(value: bool):
	returnBlocker.set_collision_layer_value(1, value)

func cameraToPlayer():
	$Player.setCameraActive()
	$agentPlanePose.set_visible(false)

func startScene():
	$Camera3D.set_current(true)
	await gc.fadeIn()
	gc.playDialogFile("res://dialog/script/greenday/intro.json")

func revealDriveJeep():
	$minnMaxLogo_EnterJeep.reveal()

func driveJeep():
	agent.set_visible(false)
	gc.playerCanMove = false
	greenDay.set_visible(false)
	$Jeep.showPassengers()
	$Jeep.canDrive = true

func openDoorOne():
	doorAnimationPlayer.play("DoorOne")
func openDoorTwo():
	doorAnimationPlayer.play("DoorTwo")
func openDoorThree():
	doorAnimationPlayer.play("DoorThree")
func openDoorFour():
	doorAnimationPlayer.play("DoorFour")
func openDoorFive():
	doorAnimationPlayer.play("DoorFive")

func _process(delta: float) -> void:
	pass

func _on_pass_door_one_area_entered(area: Area3D) -> void:
	if not onceDoorOne:
		onceDoorOne = true
		gc.playDialogFile("res://dialog/script/greenday/prior_door_two.json")

func _on_pass_door_two_area_entered(area: Area3D) -> void:
	if not onceDoorTwo:
		onceDoorTwo = true
		gc.playDialogFile("res://dialog/script/greenday/prior_door_three.json")

func _on_pass_door_three_area_entered(area: Area3D) -> void:
	if not onceDoorThree:
		onceDoorThree = true
		gc.playDialogFile("res://dialog/script/greenday/prior_door_four.json")

func _on_pass_door_four_area_entered(area: Area3D) -> void:
	if not onceDoorFour:
		onceDoorFour = true
		gc.playDialogFile("res://dialog/script/greenday/prior_door_five.json")

func _on_pass_door_five_area_entered(area: Area3D) -> void:
	if not onceDoorFive:
		onceDoorFive = true
		toggleReturnBlocker(true)
		gc.playDialogFile("res://dialog/script/greenday/exit_jeep.json")

func exitJeep():
	$Jeep.canDrive = false
	agent.set_position($SecondPlayerPosition.get_position())
	agent.resetCamera()
	agent.setCameraActive()
	$Jeep.hideAgent()
	agent.set_visible(true)
	gc.playerCanMove = true

func camera3D_AgentToCroissant():
	$Camera3D_AgentToCroissant.set_current(true)
	gc.playerCanMove = false
	agent.set_visible(false)
	$fortyIdleNoAnim.set_visible(true)
