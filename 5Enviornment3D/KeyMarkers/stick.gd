extends Node3D

@export var collect_sound: AudioStream
@onready var area = $Area3D
@onready var give_item = $GiveItem


func _ready():
	
	area.body_entered.connect(_on_body_entered)
	$GiveItem.item_name = "stick"

func _on_body_entered(body):
	give_item.give_item_to(body)
	print("item added from composition")
	if collect_sound:
		var audio = AudioStreamPlayer3D.new()
		audio.stream = collect_sound
		add_child(audio)
		audio.play()

	queue_free()
