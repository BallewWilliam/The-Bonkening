extends Control

func _ready():
	pass

func _on_start_pressed():
	get_tree().change_scene_to_file("res://AreaScenes/noelle_test.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_readme_pressed():
	get_tree().change_scene_to_file("res://AreaScenes/read_me.tscn")
