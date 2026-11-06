extends Node3D

const scenes = {
	"logo": preload("res://scene/logo.tscn"),
	"splash": preload("res://scene/splash.tscn"),
	"mainMenu": preload("res://scene/main_menu.tscn"),
	"apartment": preload("res://scene/apartment.tscn"),
}

var animationPlayer

func _ready() -> void:
	animationPlayer = $AnimationPlayer
	loadScene("logo") # Calls "logoSceneEnds" on completion
	await fadeIn()

func fadeIn():
	animationPlayer.play("fadeIn")
	await animationPlayer.animation_finished

func fadeOut():
	animationPlayer.play("fadeOut")
	await animationPlayer.animation_finished

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

func initialUnderwaterSceneComplete():
	print("Start dialog scene post initial underwater")

func playDialogFile(fileStr: String):
	var json = JSON.parse_string(FileAccess.get_file_as_string(fileStr))
	if json:
		$CanvasLayer_Dialog.playDialog(json)

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
