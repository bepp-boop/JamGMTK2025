extends Node3D

@export var item_name: String = "default_item"
@export var collect_sound: AudioStream
@onready var area = $Area3D

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody3D:
		if body.has_method("add_item"):
			body.add_item(item_name)

		if collect_sound:
			var audio = AudioStreamPlayer3D.new()
			audio.stream = collect_sound
			add_child(audio)
			audio.play()

		queue_free()
