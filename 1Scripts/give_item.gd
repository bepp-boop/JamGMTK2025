extends Node
class_name GiveItem

@export var item_name: String = "default_item"
@export var collect_sound: AudioStream = null

func give_item_to(target: Node) -> void:
	if target is CharacterBody3D and target.has_method("add_item"):
		target.add_item(item_name)
		print("Gave item:", item_name)

		if collect_sound:
			var audio = AudioStreamPlayer3D.new()
			audio.stream = collect_sound
			add_child(audio)
			audio.play()
			audio.finished.connect(audio.queue_free)
