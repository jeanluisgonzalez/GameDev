extends CharacterBody3D

const speed = 5.0
const jump_velocity = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var acceleration = 5
var mouse_sensitivity := 0.0001
var twist_input := 0.0
var pitch_input:= 0.0

@onready var cameraPivot = $CameraPivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	
	#Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y -= jump_velocity
	# handle movement
	var input_dir = Input.get_vector("move_left","move_right","move_forward","move_back")
	var direction = (transform.basis * Vector3(input_dir.x,0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x,0, speed)
		velocity.z = move_toward(velocity.z,0, speed)
		
	move_and_slide()
	
	
		
	# To lose the mouse and prevent the movement of the camera
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			
			rotate_y(rad_to_deg(-event.relative.x * mouse_sensitivity) )
			cameraPivot.rotate_x(rad_to_deg(-event.relative.y * mouse_sensitivity))
			cameraPivot.rotation.x = clamp(cameraPivot.rotation.x,-0.5,0.5)
