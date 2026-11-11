extends Node3D

var once = false
var gc

func _ready() -> void:
	gc = get_tree().current_scene

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not once:
		once = true
		$Explosion.set_visible(true)
		$Timer.start()

func _on_timer_timeout() -> void:
	set_visible(false)
