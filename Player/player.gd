extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input:= 0.0

@onready var twistPivot = $TwistPivot
@onready var pitchPivot = $TwistPivot/PitchPivot
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward","move_back")
	
	apply_central_force(twistPivot.basis * input * 1200.0 * delta)
	
	# To lose the mouse and prevent the movement of the camera
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	twistPivot.rotate_y(twist_input)
	pitchPivot.rotate_x(pitch_input)
	pitchPivot.rotation.x = clamp(pitchPivot.rotation.x,-0.5,0.5)
	twist_input= 0.0
	pitch_input= 0.0

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
