extends Node3D

@export var canvasLayerDialog: CanvasLayer

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.commandLookup = {
		"freezePlayer": freezePlayer,
		"unfreezePlayer": unfreezePlayer,
		"objectiveGoSeeComputer": objectiveGoSeeComputer,
		"objectiveStudioDoor": objectiveStudioDoor,
		"hideDialog": hideDialog,
		"showDialog": showDialog,
		"fadeOut": fadeOut,
		"fadeIn": fadeIn,
		"hideCrossHairs": hideCrossHairs,
		"showCrossHairs": showCrossHairs,
		"startGameStream": startGameStream,
		"sceneHelicopter": sceneHelicopter,
		"loadBeachScene": loadBeachScene,
		"loadGreenDayTraining": loadGreenDayTraining,
		"loadTrainingShoot": loadTrainingShoot,
		"loadObstacleCourse": loadObstacleCourse,
		"loadTacSim": loadTacSim
	}

func showCrossHairs():
	gc.showCrossHairs(true)

func hideCrossHairs():
	gc.showCrossHairs(false)

func freezePlayer():
	gc.playerCanMove = false

func unfreezePlayer():
	gc.playerCanMove = true

func objectiveGoSeeComputer():
	gc.setObjective("Mouse to look around. WASD to move. Talk to Yu in the kitchen, and visit Richard's office upstairs.")

func objectiveStudioDoor():
	gc.setObjective("Head downstairs to the studio in the basement.")

func hideDialog():
	canvasLayerDialog.set_visible(false)

func showDialog():
	canvasLayerDialog.set_visible(true) 

func fadeOut():
	await gc.fadeOut()
	canvasLayerDialog.endAwait()

func fadeIn():
	await gc.fadeIn()
	canvasLayerDialog.endAwait()

func startGameStream():
	gc.startGameStream()

func sceneHelicopter():
	gc.sceneHelicopter()

func loadBeachScene():
	gc.loadBeachScene()

func loadGreenDayTraining():
	gc.loadGreenDayTraining()

func loadTrainingShoot():
	gc.loadTrainingShoot()

func loadObstacleCourse():
	gc.loadObstacleCourse()

func loadTacSim():
	gc.loadTacSim()
