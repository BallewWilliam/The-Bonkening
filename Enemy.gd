extends CharacterBody2D

@export var speed = 0
var playerchase = false
var player = null

func _physics_process(delta):
	if playerchase:
		position += (player.position - position)/speed
		if (player.position.x - position.x) > 0:
			$AnimatedSprite2D.play("walk_right")
		else:
			$AnimatedSprite2D.play("walk_left")


func _on_detection_area_body_entered(body):
	player = body
	playerchase = true
	


func _on_detection_area_body_exited(body):
	player = null
	playerchase = false
