extends CharacterBody3D

var speed: float = 1.0
@onready var item_object_scene = preload("res://Scenes/item_object.tscn")
@onready var state_controller = get_node("StateMachine")
@export var player: CharacterBody3D
var direction: Vector3
var Awakening: bool = false
var Attacking: bool = false
var health: int = 4
var damage: int = 3
var dying: bool = false
var just_hit: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	state_controller.change_state("Idle")
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if player:
		direction = (player.global_transform.origin - self.global_transform.origin).normalized()



	move_and_slide()


func _on_chase_player_detection_body_entered(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Run")


func _on_chase_player_detection_body_exited(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Idle")


func _on_attack_player_detection_body_entered(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Attack")


func _on_attack_player_detection_body_exited(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Run")


func _on_animation_tree_animation_finished(anim_name):
	if "Awakening" in anim_name:
		Awakening = false
	elif "Attack" in anim_name:
		if (player in get_node("attack_player_detection").get_overlapping_bodies()) and !dying:
				state_controller.change_state("Attack")
	elif "Death" in anim_name:
		death()

func death():
	var rng = randi_range(2,4)
	for i in rng:
		var item_object_temp = item_object_scene.instantiate()
		item_object_temp.global_position = self.global_position
		get_node("../../Items").add_child(item_object_temp)
	Game.gain_exp(100)
	self.queue_free()

func hit(damage: int):
	if !just_hit:
		just_hit = true
		get_node("just_hit").start()
		health -= damage
		if health < 0:
			state_controller.change_state("Death")
		#knockback
		var tween = create_tween()
		tween.tween_property(self,"global_position", global_position - (direction/1.5),0.2)

func _on_just_hit_timeout():
	just_hit = false


func _on_damage_detector_body_entered(body):
	if body.is_in_group("player"):
		body.hit(damage)
