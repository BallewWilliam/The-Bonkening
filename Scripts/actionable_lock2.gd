extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var dialogue_start_unlocked: String = "start"

func action() -> void:
	if(!PlayerInfo.has_key2):
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
		PlayerInfo.game_paused = true
		
	else:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start_unlocked)
		PlayerInfo.game_paused = true
		get_parent().queue_free()
	
