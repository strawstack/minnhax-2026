extends CanvasLayer

const objectives = {
	"a": "Mouse to look around. WASD to move. Talk to Yu in the kitchen. Visit Richard's office upstairs.",
	"b": "Head downstairs to the studio in the basement.",
	"c": "Talk to LeBooBoo in the downstairs studio.",
	"d": "Start the interview stream from the control room.",
	"e": "Listen to voice mail. Stream The Department of Parasocial Activity from the control room.",
	"f": "Get the radio.",
	"g": "Explore the beach.",
	"h": "Talk to GreenDay near the jeep.",
	"i": "Drive the jeep to the training area.",
	"i2": "Go up the stairs and meet your peers.",
	"j": "Shoot three targets.",
	"k": "Complete the course and get the flag.",
	"l": "Explore MII6.",
	"m": "Enter the TacSim.",
	"n": "Investigate LeBooBoo's mansion to find a way underground.",
	"o": "Enter the secret passage in the kitchen.",
	"p": "Press 'F' to toggle skate/walk. Retreive the secret tape.",
	"q": "Explore the forest next to LeBooBoo's mansion.",
	"q2": "Retreive the secret tape from the cage at the end of the course.",
	"r": "Go to the dock and use the boat to travel to the island.",
	"s": "Get inside the club.",
	"s2": "Explore the club.",
	"t": "Meet the contact in red.",
	"u": "Watch LeBooBoo's interview on the central dance floor. Find and take out the band member.",
	"v": "Head to the central dance floor.",
	"w": "Exit via the door at the back of the stage.",
	"x": "Extract to complete your mission."
}
const prefix = "Objective: "

func _ready() -> void:
	pass

func setObjectiveLetter(letter: String):
	if letter in objectives:
		setObjective(objectives[letter])
	else:
		print("MISSING(objective): " + letter)

func setObjective(msg: String):
	$PanelContainer/Label.set_text(prefix + msg)
