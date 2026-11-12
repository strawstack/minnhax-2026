extends Node3D

var once = false
var gc

func _ready() -> void:
	gc = get_tree().current_scene

func _on_timer_timeout() -> void:
	set_visible(false)

func _on_area_3d_area_entered(area: Area3D) -> void:
	if not once:
		once = true
		$MeshInstance3D.set_visible(false)
		$Explosion.set_visible(true)
		$Timer.start()
