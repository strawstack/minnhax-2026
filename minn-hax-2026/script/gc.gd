extends Node3D

const scenes = {
	"apartment": preload("res://scene/apartment.tscn") 
}

func _ready() -> void:
	# TODO: replace with preamble and possible main menu
	loadScene("apartment")

func playDialogFile(fileStr: String):
	var json = JSON.parse_string(FileAccess.get_file_as_string(fileStr))
	if json:
		$CanvasLayer_Dialog.playDialog(json)

func _process(_delta: float) -> void:
	pass

func loadScene(sceneName: String):
	for child in $scene.get_children():
		$scene.remove_child(child)
		child.queue_free()
	var instance = scenes[sceneName].instantiate()
	$scene.add_child(instance)

func _input(event):
	# Capture mouse on left click
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# Free mouse on esc
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
