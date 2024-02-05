extends CharacterBody2D


@export var SPEED = 100.0
@export var JUMP_VELOCITY = -300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# @onready var camera = get_node("/root/Main/Camera")
@onready var player_sprite = $AnimatedSprite2D
@onready var inhaling_effect = $InhalingEffect

func _physics_process(delta):	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("inhale"):
		inhaling_effect.visible = false
		player_sprite.play("idle")
	
	if Input.is_action_pressed("inhale"):
		player_sprite.play("isInhaling")
		inhaling_effect.play("default")
		inhaling_effect.visible = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction == 1:
		player_sprite.flip_h = false
	if direction == -1:
		player_sprite.flip_h = true
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
