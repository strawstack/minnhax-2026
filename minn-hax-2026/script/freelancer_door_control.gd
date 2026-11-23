extends Node3D

var once = false

func _on_body_entered(body: Node3D) -> void:
	if not once:
		once = true
		$AnimationPlayer.play("open")
