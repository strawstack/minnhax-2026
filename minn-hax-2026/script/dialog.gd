extends CanvasLayer

# Structure Explination
# Dialog typeof Mesage[]
# Mesage typeof Dict: Name, Avatar, Lines typeof Line[]
# Line typeof Dict: voice_file, text

# State
const dialogState = {
	"NOT_PLAYING": 0,
	"LOAD_LINE": 1,
	"ANIMATING_LINE": 2,
	"WAITING_FOR_INPUT": 3,
}
var state = dialogState.NOT_PLAYING

# Variables
var activeDialog = null
var activeLine = null
var messageIndex = 0
var lineIndex = 0
var charIndex = 0

var label_Message

const letterSpeed = 40
const punctuationSpeed = 2

func _ready() -> void:
	showDialog(false)
	label_Message = $Label_Message

func resetDialog():
	messageIndex = 0
	lineIndex = 0
	charIndex = 0
	label_Message.set_text("")

# Call with JSON obj to trigger a set of dialog boxes in succession
func playDialog(dialog: Array):
	if state == dialogState.NOT_PLAYING:
		resetDialog()
		activeDialog = dialog
		state = dialogState.LOAD_LINE
		showDialog(true)

# Set image and character name in UI
func setAvatar(message: Dictionary):
	print("TODO: Set avatar image")
	$Label_CharacterName.set_text(message["name"])

# Set dialog visibility in UI
func showDialog(value: bool):
	visible = value

# Place line in label in UI
func setLine(line: String):
	label_Message.set_text(line)

func playVoice(voiceFile: String):
	print("TODO: play voice")

# Called to ensure voice audio stops when player advances to next line
func stopVoice():
	print("TODO: stop voice")

# Set number of visible characters in label
func setCharacterVisible(charIndex: float):
	label_Message.set_visible_characters(charIndex)

func _process(delta: float) -> void:
	if state == dialogState.LOAD_LINE:
		var message = activeDialog[messageIndex]
		setAvatar(message)
		activeLine = message["lines"][lineIndex]
		charIndex = 0
		setCharacterVisible(charIndex)
		setLine(activeLine["text"])
		playVoice(activeLine["voice"])
		state = dialogState.ANIMATING_LINE

	if state == dialogState.WAITING_FOR_INPUT:
		if Input.is_action_just_pressed("enter"):
			stopVoice()
			lineIndex += 1
			if lineIndex >= activeDialog[messageIndex]["lines"].size():
				lineIndex = 0
				messageIndex += 1
			if messageIndex >= activeDialog.size():
				state = dialogState.NOT_PLAYING
				showDialog(false)
			else:
				state = dialogState.LOAD_LINE

	if state == dialogState.ANIMATING_LINE:
		if Input.is_action_just_pressed("enter"):
			charIndex = activeLine["text"].length()
			setCharacterVisible(charIndex)
			state = dialogState.WAITING_FOR_INPUT

		elif charIndex >= activeLine["text"].length():
			state = dialogState.WAITING_FOR_INPUT

		else:
			var isLetter = not ".?!,;".contains(activeLine["text"][max(0, charIndex - 1)])
			var speed = letterSpeed if isLetter else punctuationSpeed
			charIndex += delta * speed
			setCharacterVisible(charIndex)
