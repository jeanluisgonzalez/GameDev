extends Node
class_name InputGatherer

func gather_input()-> InputPackage:
	var new_input = InputPackage.new()
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		new_input.is_jumping = true
	
	new_input.input_direction = Input.get_vector("left", "right", "forward", "backward")
	
	return new_input
