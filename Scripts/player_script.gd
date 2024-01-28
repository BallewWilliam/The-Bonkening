extends CharacterBody2D

# set of rotation values for character rotation (note: the actual rotation value for the node is not used)
enum ROTATION_STATES
{
	UP = 0,
	DOWN = 1,
	LEFT = 2,
	RIGHT = 3
}

@export var speed = 250
var can_move = true
var can_change_rotation = true
var attacking = false
var curr_rotation_state = ROTATION_STATES.DOWN


# Called when the node enters the scene tree for the first time.
func _ready():
	$Hitboxes/RightHitbox/CollisionShape2D.set_deferred("disabled", true)
	$Hitboxes/LeftHitbox/CollisionShape2D.set_deferred("disabled", true)
	$Hitboxes/UpHitbox/CollisionShape2D.set_deferred("disabled", true)
	$Hitboxes/DownHitbox/CollisionShape2D.set_deferred("disabled", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if can_move == true:
		get_input()
		move_and_slide()		

func _on_animated_sprite_2d_animation_finished():
	if(attacking == true):
		attacking = false
		can_move = true
		can_change_rotation = true
		if(curr_rotation_state == ROTATION_STATES.RIGHT):
			$AnimatedSprite2D.play("right_stand")
			$Hitboxes/RightHitbox/CollisionShape2D.set_deferred("disabled", true)
		elif(curr_rotation_state == ROTATION_STATES.LEFT):
			$AnimatedSprite2D.play("left_stand")
			$Hitboxes/LeftHitbox/CollisionShape2D.set_deferred("disabled", true)
		elif(curr_rotation_state == ROTATION_STATES.UP):
			$AnimatedSprite2D.play("up_stand")
			$Hitboxes/UpHitbox/CollisionShape2D.set_deferred("disabled", true)
		elif(curr_rotation_state == ROTATION_STATES.DOWN):
			$AnimatedSprite2D.play("down_stand")
			$Hitboxes/DownHitbox/CollisionShape2D.set_deferred("disabled", true)


# obtains input for movement, sets rotation state, and sets sprite animation
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	# sets if the player's rotation can be changed.
	if(can_change_rotation == false):
		if(curr_rotation_state == ROTATION_STATES.RIGHT):
			if(Input.get_action_strength("right") == 0 || Input.get_action_strength("left") > 0):
				can_change_rotation = true
		elif(curr_rotation_state == ROTATION_STATES.LEFT):
			if(Input.get_action_strength("left") == 0 || Input.get_action_strength("right") > 0):
				can_change_rotation = true
		elif(curr_rotation_state == ROTATION_STATES.UP):
			if(Input.get_action_strength("up") == 0 || Input.get_action_strength("down") > 0):
				can_change_rotation = true
		elif(curr_rotation_state == ROTATION_STATES.DOWN):
			if(Input.get_action_strength("down") == 0 || Input.get_action_strength("up") > 0):
				can_change_rotation = true
				
	# changes the rotation of the player
	if((abs(input_direction.x) > 0 || abs(input_direction.y) > 0) && can_change_rotation):
		if(Input.get_action_strength("right") > 0):
			curr_rotation_state = ROTATION_STATES.RIGHT
			$AnimatedSprite2D.play("right_walk")
			can_change_rotation = false
		elif(Input.get_action_strength("left") > 0):
			curr_rotation_state = ROTATION_STATES.LEFT
			$AnimatedSprite2D.play("left_walk")
			can_change_rotation = false
		elif(Input.get_action_strength("up") > 0):
			curr_rotation_state = ROTATION_STATES.UP
			$AnimatedSprite2D.play("up_walk")
			can_change_rotation = false
		elif(Input.get_action_strength("down") > 0):
			curr_rotation_state = ROTATION_STATES.DOWN
			$AnimatedSprite2D.play("down_walk")
			can_change_rotation = false
	elif(input_direction.x == 0 && input_direction.y == 0):
		match curr_rotation_state:
			ROTATION_STATES.RIGHT:
				$AnimatedSprite2D.play("right_stand")
			ROTATION_STATES.LEFT:
				$AnimatedSprite2D.play("left_stand")
			ROTATION_STATES.UP:
				$AnimatedSprite2D.play("up_stand")
			ROTATION_STATES.DOWN:
				$AnimatedSprite2D.play("down_stand")
	
	# Handles attacking
	if(Input.is_action_just_pressed("attack")):
		can_move = false
		can_change_rotation = false
		attacking = true
		if(curr_rotation_state == ROTATION_STATES.RIGHT):
			$Hitboxes/RightHitbox/CollisionShape2D.set_deferred("disabled", false)
			$AnimatedSprite2D.play("right_attack")			
		elif(curr_rotation_state == ROTATION_STATES.LEFT):
			$Hitboxes/LeftHitbox/CollisionShape2D.set_deferred("disabled", false)
			$AnimatedSprite2D.play("left_attack")
		elif(curr_rotation_state == ROTATION_STATES.UP):
			$Hitboxes/UpHitbox/CollisionShape2D.set_deferred("disabled", false)
			$AnimatedSprite2D.play("up_attack")			
		elif(curr_rotation_state == ROTATION_STATES.DOWN):
			$Hitboxes/DownHitbox/CollisionShape2D.set_deferred("disabled", false)
			$AnimatedSprite2D.play("down_attack")
			
		
	




