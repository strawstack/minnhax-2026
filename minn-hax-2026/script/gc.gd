extends Node3D

func _ready() -> void:
	# DEBUG: Code for texting dialog 
	var json = JSON.parse_string(FileAccess.get_file_as_string("res://dialog/script/example.json"))
	if json:
		$CanvasLayer_Dialog.playDialog(json)

func _process(delta: float) -> void:
	pass

func _input(event):
	# Capture mouse on left click
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# Free mouse on esc
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
