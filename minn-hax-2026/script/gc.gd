extends Node3D

const DEBUG = false

@export var commands: Node3D

const scenes = {
	"logo": preload("res://scene/logo.tscn"),
	"splash": preload("res://scene/splash.tscn"),
	"mainMenu": preload("res://scene/main_menu.tscn"),
	"apartment": preload("res://scene/apartment.tscn"),
}

# commandLookup populated by Commands child node 
var commandLookup = {}
# If command is not present, checks sceneCommandLookup which is populated by scene
var sceneCommandLookup = {}

var animationPlayer
var dialogInProgress = false # Set when dialog is in progress
var playerCanMove = false

# CharacterName to mouthNode lookup
var mouthLookup = {}

# ref
var audioStreamPlayerVoice: AudioStreamPlayer

func _ready() -> void:
	animationPlayer = $AnimationPlayer
	audioStreamPlayerVoice = $Audio/AudioStreamPlayerVoice
	hideInteract()
	showCrossHairs(false)
	if DEBUG:
		$CanvasLayer_Fade/fadeRect.set_visible(false)
		loadScene("apartment")
	else:
		$CanvasLayer_Fade.set_visible(true) # Just to make sure
		loadScene("logo") # Calls "logoSceneEnds" on completion
		await fadeIn()

func showCrossHairs(value):
	$CanvasLayer_Interact/TextureRect.set_visible(value)

func setPlayerCanMove(value):
	playerCanMove = value

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

func registerMouth(name, mouthNode):
	mouthLookup[name] = mouthNode

func playVoice(voiceFile: String):
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

func startEvent(name: String):
	# TODO a minnmax logo either has a dialog file or is calls this function to request execution of a set of steps 
	print("TODO lookup name in eventLookup and run associated function which is a list of world events")

func triggerCommand(command: String):
	if command in commandLookup:
		commandLookup[command].call()
	elif command in sceneCommandLookup:
		sceneCommandLookup[command].call()

func setMouth(name: String):
	for characterName in mouthLookup:
		mouthLookup[characterName].setIsSpeaking(characterName == name)

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
