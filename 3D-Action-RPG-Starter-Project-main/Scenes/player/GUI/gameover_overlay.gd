extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

func game_over():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	self.show()
	get_tree().paused = true
