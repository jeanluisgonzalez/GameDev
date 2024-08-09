extends CanvasLayer

@onready var hp_bar = get_node("hp_bar")
func _ready():
	hp_bar.max_value = Game.player_health_max
	get_node("container").hide()
	get_node("container/profile").hide()
	get_node("container/VBoxContainer/inventory_button").disabled = true
	var gameNode = get_node(Game.get_path())
	gameNode.health_changed.connect(Callable(self,"_on_node_health_changed"))
func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		get_node("container").visible = get_tree().paused
		match get_tree().paused:
			true:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			false:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_inventory_button_pressed():
	get_node("container/VBoxContainer/inventory_button").disabled = true
	get_node("container/VBoxContainer/profile_button").disabled = false
	get_node("container/inventory").show()
	get_node("container/profile").hide()


func _on_profile_button_pressed():
	get_node("container/VBoxContainer/inventory_button").disabled = false
	get_node("container/VBoxContainer/profile_button").disabled = true
	get_node("container/inventory").hide()
	get_node("container/profile").show()
	
func _on_node_health_changed(damage: int):
	var tween = create_tween()
	tween.tween_property(hp_bar,"value",hp_bar.value - damage, 0.2)
