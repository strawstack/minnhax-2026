extends Node3D

func getActive():
	for player in get_children():
		if player.is_visible():
			return player
