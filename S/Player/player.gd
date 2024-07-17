extends CharacterBody3D

@onready var camera_mount = $camera_mount
@onready var animation_player = $visuals/Player/AnimationPlayer
@onready var visuals = $visuals


var SPEED = 3.5
const JUMP_VELOCITY = 4.5

var walking_speed = 3.5
var running_speed = 5.0
var running = false

@export var sens_horizontal = 0.5
@export  var sens_vertical = 0.1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))
		camera_mount.rotation.x= clamp(camera_mount.rotation.x,-0.5,0.5)

func _physics_process(delta):
	
	if Input.is_action_pressed("run"):
		SPEED = running_speed
	else:
		SPEED = walking_speed
		
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left","move_right","move_forward","move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if animation_player.current_animation != "Walk":
			animation_player.play("Walk")
			
		
		visuals.look_at(position + direction)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animation_player.current_animation != "Idle":
			animation_player.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
