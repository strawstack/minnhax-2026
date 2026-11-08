extends CanvasLayer

# Objectives
# Mouse to look around. WASD to move. Talk to Yu in the kitchen, and see my office upstairs.
# Head downstairs to the studio in the basement.
# Talk to LeBooBoo in the downstairs studio.
# Start the interview stream from the control room.
# Get the radio.
# Explore the beach.
# Talk to GreenDay near the jeep.
# Drive to the training area.
# (Objectives off during training)
# Explore MII6.
# Enter the TacSim.
# Investigate LeBooBoo's mansion.
# Enter the secret passage in the kitchen revealed by the banana.
# Press 'F' to toggle skate/walk. Retreive the secret tape.
# Explore the forest next to LeBooBoo's mansion.
# Go to the dock and use the boat to travel to the island.
# Get inside the club.
# Explore the club.
# Distract LeBooBoo's band member in order to replace them on stage.
# Join LeBooBoo on stage. Stay close. Hack his phone.
# Exit via the door at the back of the stage.
# Extract to complete your mission.

const prefix = "Objective: "

func _ready() -> void:
	pass

func setObjective(msg: String):
	set_visible(true)
	$PanelContainer/Label.set_text(prefix + msg)

func _process(delta: float) -> void:
	pass
