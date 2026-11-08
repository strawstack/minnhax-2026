extends Node3D

@export var characterName: String
@export var teethOveride: Texture2D

# Const
const MAX_MOUTH_SCALE = 0.15
const MOUTH_SIZE_BOOST = 0.06
const TEETH_CUTOFF = 0.00005

# Ref
var spectrum_instance
var space
var teeth

# Var
var isSpeaking = false

var gc

func _ready() -> void:
	gc = get_tree().current_scene
	# TODO register with gc using exported "characterName" parameter
	space = $Space
	teeth = $Teeth
	if teethOveride:
		teeth.set_texture(teethOveride)
	spectrum_instance = AudioServer.get_bus_effect_instance(2, 0)  # Bus 1, Effect 0
	gc.registerMouth(characterName, self)

func setIsSpeaking(value):
	isSpeaking = value

func _process(_delta: float) -> void:
	if isSpeaking:
		var magnitude = spectrum_instance.get_magnitude_for_frequency_range(0, 1000).length()
		
		# Show hide teeth
		var showTeeth = magnitude <= TEETH_CUTOFF
		space.set_visible(not showTeeth)
		teeth.set_visible(showTeeth)
		
		# Scale mouth space
		var scale = min(MAX_MOUTH_SCALE, magnitude * MAX_MOUTH_SCALE + MOUTH_SIZE_BOOST)
		var lerp_scale = lerp(space.get_scale().x, scale, 0.9)
		space.set_scale(Vector3(lerp_scale, lerp_scale, 1))
	else:
		space.set_visible(false)
		teeth.set_visible(true)
