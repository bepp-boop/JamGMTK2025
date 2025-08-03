extends Node 
@onready var switch_manager = get_tree().get_first_node_in_group("switch_manager")

func end():
	if switch_manager:
		switch_manager.end_current_player()
