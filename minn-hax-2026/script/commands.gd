extends Node3D

@export var canvasLayerDialog: CanvasLayer

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	gc.commandLookup = {
		"freezePlayer": freezePlayer,
		"unfreezePlayer": unfreezePlayer,
		"hideDialog": hideDialog,
		"showDialog": showDialog,
		"fadeOut": fadeOut,
		"fadeIn": fadeIn,
		"hideCrossHairs": hideCrossHairs,
		"showCrossHairs": showCrossHairs,
		"startGameStream": startGameStream,
		"sceneHelicopter": sceneHelicopter,
		"loadBeachParty": loadBeachParty,
		"loadBeachScene": loadBeachScene,
		"loadGreenDayTraining": loadGreenDayTraining,
		"loadTrainingShoot": loadTrainingShoot,
		"loadObstacleCourse": loadObstacleCourse,
		"loadTacSim": loadTacSim,
		"loadFreelancer": loadFreelancer,
		"loadCredits": loadCredits,
		"hideObjective": hideObjective,
		"showObjective": showObjective
	}

func hideObjective():
	gc.hideObjective()

func showObjective():
	gc.showObjective()

func showCrossHairs():
	gc.showCrossHairs(true)

func hideCrossHairs():
	gc.showCrossHairs(false)

func freezePlayer():
	gc.playerCanMove = false

func unfreezePlayer():
	gc.playerCanMove = true

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

func loadBeachParty():
	gc.loadBeachParty()

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

func loadFreelancer():
	gc.loadFreelancer()

func loadCredits():
	gc.loadCredits()
