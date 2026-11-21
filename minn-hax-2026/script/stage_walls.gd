extends Node3D

func activateWalls(value: bool):
	$WallOne.set_collision_layer_value(5, value)
	$WallTwo.set_collision_layer_value(5, value)
	$WallThree.set_collision_layer_value(5, value)
