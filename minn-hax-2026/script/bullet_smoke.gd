extends Node3D

var lines: Array[Node]
var currentIndex = 0

var tweens: Array[Tween]

func _ready() -> void:
	lines = get_children()
	for line in lines:
		line.set_visible(false)

func draw_thick_line(from: Vector3, to: Vector3, thickness := 0.02):
	var direction = to - from
	var length = direction.length()

	if currentIndex == 3:
		currentIndex = 0

	if currentIndex < tweens.size():
		tweens[currentIndex].kill()

	var mesh_instance = lines[currentIndex]
	var cylinder = lines[currentIndex].get_mesh()

	cylinder.top_radius = thickness
	cylinder.bottom_radius = thickness
	cylinder.height = length

	mesh_instance.global_position = (from + to) / 2.0
	mesh_instance.look_at(to, Vector3.UP)
	mesh_instance.rotate_object_local(Vector3.RIGHT, PI / 2.0)
	
	var material = mesh_instance.get_surface_override_material(0)
	
	material.albedo_color.a = 0.5
	mesh_instance.set_visible(true)
	
	var tween = create_tween()
	tween.tween_property(material, "albedo_color:a", 0.0, 2.0)
	
	if tweens.size() < currentIndex + 1:
		tweens.push_back(tween)
	else:
		tweens[currentIndex] = tween

	currentIndex += 1
