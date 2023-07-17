extends CharacterBody2D



@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim_sprite = $player_sprite
@onready var anim_sprite2 = get_node("player_sprite")

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		anim_sprite.animation = "idle_green"
	# Handle Jump.
	else:
		anim_sprite.animation = "idle_blue"
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_left"):
		# flip sprite
		anim_sprite.Transform.Scale.x = -1
		print("left")
	elif Input.is_action_just_pressed("ui_right"):
		print("right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
