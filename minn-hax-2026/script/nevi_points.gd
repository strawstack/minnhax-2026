extends Node3D

@export var nevi: Node3D
@export var player: CharacterBody3D
@export var meowTimer: Timer

var points: Array[Node]
var previousClosePoint = null

var move_speed = 3
var rotation_speed = 10

var neviCanMove = false

var gc

var canMeow = true

var silence = false

func _ready() -> void:
	gc = get_tree().current_scene
	points = get_children()

func travel(point: Node3D):
	nevi.set_position(point.get_position())

func _process(delta: float) -> void:
	if not neviCanMove:
		return

	var closePoint = null
	var closeDistance = INF
	var pos = player.get_position()
	for point in points:
		var distance = (point.get_position() - pos).length()
		if distance < closeDistance:
			closeDistance = distance
			closePoint = point
	if previousClosePoint != closePoint:
		previousClosePoint = closePoint
		if canMeow:
			canMeow = false
			meowTimer.start()
			if not silence:
				gc.playSoundEffect("meow")

	nevi.set_position(nevi.get_position().lerp(closePoint.get_position(), move_speed * delta))
	nevi.set_rotation(nevi.get_rotation().lerp(closePoint.get_rotation(), rotation_speed * delta))

func _on_meow_timer_timeout() -> void:
	canMeow = true
