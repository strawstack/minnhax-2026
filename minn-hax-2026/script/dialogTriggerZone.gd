extends Area3D

@export var dialogFile: String

var gc
var triggerOnce = false

func _ready() -> void:
	gc = get_tree().current_scene

func _on_body_entered(body: Node3D) -> void:
	if not triggerOnce:
		triggerOnce = true
		gc.playDialogFile(dialogFile)
