extends CharacterBody2D

# set of rotation values for character rotation (note: the actual rotation value for the node is not used)
enum ROTATION_STATES
{
	UP = 0,
	DOWN = 1,
	LEFT = 2,
	RIGHT = 3
}

@export var speed = 200
var can_move = true
var can_change_rotation = true
var curr_rotation_state = ROTATION_STATES.DOWN


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if can_move == true:
		get_input_and_rotate()
		move_and_slide()
		

# obtains input for movement, sets rotation state, and sets sprite animation
func get_input_and_rotate():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	# checks if the player's rotation can be changed.
	if(can_change_rotation == false):
		if(curr_rotation_state == ROTATION_STATES.RIGHT):
			if(Input.get_action_strength("right") == 0):
				can_change_rotation = true
	if(curr_rotation_state == ROTATION_STATES.LEFT):
			if(Input.get_action_strength("left") == 0):
				can_change_rotation = true
	if(curr_rotation_state == ROTATION_STATES.UP):
			if(Input.get_action_strength("up") == 0):
				can_change_rotation = true
	if(curr_rotation_state == ROTATION_STATES.DOWN):
			if(Input.get_action_strength("down") == 0):
				can_change_rotation = true
	
	# changes the rotation of the player
	if((input_direction.x > 0 || input_direction.y > 0) && can_change_rotation && can_move):
		if(Input.get_action_strength("right") > 0):
			curr_rotation_state = ROTATION_STATES.RIGHT
			can_change_rotation = false
		elif(Input.get_action_strength("left") > 0):
			curr_rotation_state = ROTATION_STATES.LEFT
			can_change_rotation = false
		elif(Input.get_action_strength("up") > 0):
			curr_rotation_state = ROTATION_STATES.UP
			can_change_rotation = false
		elif(Input.get_action_strength("down") > 0):
			curr_rotation_state = ROTATION_STATES.DOWN
			can_change_rotation = false
	
