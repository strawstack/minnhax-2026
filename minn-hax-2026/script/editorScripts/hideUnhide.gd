@tool
extends EditorScript

var show = true

func toggleChildren(node, value):
	node.set_visible(value)
	for child in node.get_children():
		toggleChildren(child, value)

func _run():
	var editor: EditorSelection = EditorInterface.get_selection()
	var nodes = editor.get_selected_nodes()
	for node in nodes:
		toggleChildren(node, show)
