extends CharacterBody2D

var coins = 0
var SPEED = 400.0
var JUMP_VELOCITY = -500.0
#var jump_max = 2
#var jump_count = 0
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	
	#Code for double jump if we want it
#	if is_on_floor():
#		jump_count = 0
#	else:
#		if jump_count == 0:
#			jump_count += 1
#
#	# Handle Jump.
#	if jump_count < jump_max:
#		if Input.is_action_just_pressed("ui_accept"):
#			velocity.y = JUMP_VELOCITY
#			jump_count += 1
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("throw_coin"):
		throw_coin()

func add_coin():
	coins += 1
	print("Num coins: " + str(coins))
	print("Speed: " + str(SPEED))
	print("Jump Height: " + str(JUMP_VELOCITY))
#	if coins >= 10:
#		SPEED -= 100
#		JUMP_VELOCITY += 100
#		if SPEED <= 200 or JUMP_VELOCITY >= -100:
#			SPEED = 200
#			JUMP_VELOCITY = 100

func throw_coin():
	if coins <= 0:
		coins = 0
		return
	else:
		coins -= 1
	print("Num coins: " + str(coins))
