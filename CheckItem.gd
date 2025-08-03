extends Node
class_name CheckItem

@export var required_items: Array[String] = ["default_item"]
@export var require_all: bool = true  # If false, any one item is enough

func has_required_items(target: Node) -> bool:
	if target is CharacterBody3D and target.has_method("has_item"):
		if require_all:
			for item in required_items:
				if not target.has_item(item):
					return false
			return true
		else:
			for item in required_items:
				if target.has_item(item):
					return true
			return false
	else:
		push_warning("Target does not support inventory checking.")
		return false
