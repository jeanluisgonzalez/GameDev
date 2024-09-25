extends CharacterBody3D
@onready var camera_mount = $camera_mount
@onready var animation_player = $visuals/character/AnimationPlayer
@onready var visuals = $visuals

var SPEED = 3.0
const JUMP_VELOCITY = 4.5
var walking_speed = 3.0
var running_speed = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var running = false
var is_locked = false
@export var sens_horizontal = 0.2
@export var sens_vertical = 0.2

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))
func _physics_process(delta):
	var input_dir = gather_input()
	velocity = velocity_by_input(input_dir,delta)
	move_and_slide()
func velocity_by_input(input_dir : InputPackage, delta: float) -> Vector3:
	var new_velocity = Vector3.ZERO
	
	var direction = (transform.basis * Vector3(input_dir.input_direction.x, 0, input_dir.input_direction.y)).normalized()
	if direction:
		new_velocity.x = direction.x * SPEED
		new_velocity.z = direction.z * SPEED
	else:
		new_velocity.x = move_toward(velocity.x, 0, SPEED)
		new_velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if input_dir.is_jumping and is_on_floor():
		print("is jumping")
		new_velocity.y += JUMP_VELOCITY
	# Add the gravity.
	if not is_on_floor():
		new_velocity.y -= gravity * delta
	
	return new_velocity
