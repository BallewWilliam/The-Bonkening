extends CharacterBody2D

@export var speed = 70
@export var health = 1
var playerchase = false
var player = null

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if(playerchase && player != null && !PlayerInfo.game_paused):
		position += (player.position - position)/speed

func _on_detection_area_body_entered(body):
	player = body
	playerchase = true

func _on_detection_area_body_exited(body):
	player = null
	playerchase = false

func _on_stop_area_body_entered(body):
	if(body.is_in_group("player")):
		playerchase = false
		$CooldownTimer.start()
	
func _on_cooldown_timer_timeout():
	playerchase = true

func _on_stop_area_area_entered(area):
	if(area.is_in_group("PlayerHitbox")):
		die()
		print("help")
		
func die():
	playerchase = false
	$DetectionArea/CollisionShape2D.set_deferred("disabled", true)
	$StopArea/CollisionShape2D.set_deferred("disabled", true)
	$CooldownTimer.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play("dead")
		
