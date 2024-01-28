extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func action() -> void:
	PlayerInfo.has_key2 = true
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	PlayerInfo.game_paused = true
	$Sprite2D.queue_free()
	queue_free()
