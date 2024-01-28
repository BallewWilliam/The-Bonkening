extends CharacterBody2D

@export var health = 1

func _on_stop_area_area_entered(area):
	if(area.is_in_group("PlayerHitbox")):
		die()
	
		
func die():
	get_tree().change_scene_to_file("res://AreaScenes/victory_screen.tscn")
