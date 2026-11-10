extends Node3D

const DEBUG = true

@export var commands: Node3D
@export var bulletSmoke: Node3D

const scenes = {
	"logo": preload("res://scene/logo.tscn"),
	"splash": preload("res://scene/splash.tscn"),
	"mainMenu": preload("res://scene/main_menu.tscn"),
	"apartment": preload("res://scene/apartment.tscn"),
	"underwater": preload("res://scene/underwater.tscn"),
	"helicopter": preload("res://scene/helicopter.tscn"),
	"beach": preload("res://scene/beach.tscn"),
}

# commandLookup populated by Commands child node 
var commandLookup = {}
# If command is not present, checks sceneCommandLookup which is populated by scene
var sceneCommandLookup = {}

var animationPlayer
var dialogInProgress = false # Set when dialog is in progress
var playerCanMove = false

# Controls if player looks at watch when underwater scene plays
var lookWatchUnderwater = false

# CharacterName to mouthNode lookup
var mouthLookup = {}

# ref
var audioStreamPlayerVoice: AudioStreamPlayer

func _ready() -> void:
	animationPlayer = $AnimationPlayer
	audioStreamPlayerVoice = $Audio/AudioStreamPlayerVoice
	hideInteract()
	showCrossHairs(false)
	hideObjective()
	if DEBUG:
		loadScene("beach")
	else:
		$CanvasLayer_Fade.set_visible(true) # Just to make sure
		loadScene("logo") # Calls "logoSceneEnds" on completion
		await fadeIn()

func hideDialog():
	$CanvasLayer_Dialog.set_visible(false)

func showCrossHairs(value):
	$CanvasLayer_Interact/TextureRect.set_visible(value)

func setPlayerCanMove(value):
	playerCanMove = value

func setObjective(msg: String):
	$CanvasLayer_Objective.setObjective(msg)

func hideObjective():
	$CanvasLayer_Objective.set_visible(false)

func endAwaitDialog():
	$CanvasLayer_Dialog.endAwait()

func fadeIn():
	animationPlayer.play("fadeIn")
	await animationPlayer.animation_finished

func fadeOut():
	animationPlayer.play("fadeOut")
	await animationPlayer.animation_finished

func showInteract(msg):
	$CanvasLayer_Interact/PanelContainer/Label.set_text(msg)
	$CanvasLayer_Interact/PanelContainer.set_visible(true)

func hideInteract():
	$CanvasLayer_Interact/PanelContainer.set_visible(false)

func registerMouth(characterName, mouthNode):
	if characterName in mouthLookup:
		mouthLookup[characterName].push_back(mouthNode)
	else:
		mouthLookup[characterName] = [mouthNode]

func playVoice(voiceFile: String):
	if voiceFile != "":
		var audio = load(
			"res://dialog/vocal/" + voiceFile + ".mp3"
		)
		if audio:
			audioStreamPlayerVoice.stream = audio
			audioStreamPlayerVoice.play()

func stopVoice():
	audioStreamPlayerVoice.stop()

func logoSceneEnds():
	await fadeOut()
	await get_tree().create_timer(1.0).timeout
	loadScene("splash")
	await fadeIn()
	await get_tree().create_timer(4.0).timeout
	await fadeOut()
	loadScene("mainMenu") # Calls "mainMenuStartPress" on completion
	await fadeIn()

func mainMenuStartPress():
	await fadeOut()
	loadScene("apartment") # Calls "initialUnderwaterSceneComplete" on complete
	await fadeIn()

func playDialogFile(fileStr: String):
	var json = JSON.parse_string(FileAccess.get_file_as_string(fileStr))
	if json:
		dialogInProgress = true
		$CanvasLayer_Dialog.playDialog(json)

func triggerCommand(command: String):
	if command in commandLookup:
		commandLookup[command].call()
	elif command in sceneCommandLookup:
		sceneCommandLookup[command].call()
	else:
		print("TODO: Command not found: " + command)

func setMouth(name: String):
	for characterName in mouthLookup:
		for mouth in mouthLookup[characterName]:
			mouth.setIsSpeaking(characterName == name)

# Called when a dialog ends indicating a new one can be started
func dialogEnds():
	dialogInProgress = false

func _process(_delta: float) -> void:
	pass

func loadScene(sceneName: String):
	for child in $Scene.get_children():
		$Scene.remove_child(child)
		child.queue_free()
	var instance = scenes[sceneName].instantiate()
	$Scene.add_child(instance)

func _input(event):
	# Capture mouse on left click
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# Free mouse on esc
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func draw_thick_line(from: Vector3, to: Vector3):
	bulletSmoke.draw_thick_line(from, to)

# Called by interacting with Control Room 2 prompt after morning voice mail
func startGameStream():
	await fadeOut()
	mouthLookup.clear()
	lookWatchUnderwater = true
	showCrossHairs(false)
	sceneCommandLookup.clear()
	loadScene("underwater")

func sceneHelicopter():
	await fadeOut()
	loadScene("helicopter")

func loadBeachScene():
	playerCanMove = false
	await fadeOut()
	loadScene("beach")
