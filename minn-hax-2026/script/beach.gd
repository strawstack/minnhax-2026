extends Node3D

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.sceneCommandLookup = {
		"removeStaticBody3D_UntilRadio": removeStaticBody3D_UntilRadio,
		"removeStaticBody3D_AlrightBlock": removeStaticBody3D_AlrightBlock,
		"removeStaticBody3D_ShimmyBlock": removeStaticBody3D_ShimmyBlock,
		"pickUpBeachTape": pickUpBeachTape,
		"pickUpRadio": pickUpRadio
	}
	startScene()

func pickUpRadio():
	$Radio.set_visible(false)
	gc.setObjectiveLetter("g")

func startScene():
	# Wait for rocket explosion sound effect
	await get_tree().create_timer(3.0).timeout
	gc.playerCanMove = true
	await gc.fadeIn()
	gc.setObjectiveLetter("f")
	gc.playDialogFile("res://dialog/script/3_beach/12_a_agent_on_beach.json")

func pickUpBeachTape():
	gc.playSoundEffect("success")

func removeStaticBody3D_UntilRadio():
	$blocksAndAreas/StaticBody3D_UntilRadio.set_collision_layer_value(5, false)

func removeStaticBody3D_AlrightBlock():
	$blocksAndAreas/StaticBody3D_AlrightBlock.set_collision_layer_value(5, false)

func removeStaticBody3D_ShimmyBlock():
	$blocksAndAreas/StaticBody3D_ShimmyBlock.set_collision_layer_value(5, false)

func _process(delta: float) -> void:
	pass
