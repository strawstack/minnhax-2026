@tool
extends EditorScript

func _run() -> void:
	var editor: EditorSelection = EditorInterface.get_selection()
	var trees = editor.get_selected_nodes()
	var rand = RandomNumberGenerator.new()
	for tree in trees[0].get_children():
		tree.rotate_y(rand.randf_range(0, 2 * PI))
