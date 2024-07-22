extends CharacterBody3D

@export var gravity: float = 9.8
@export var jump_force: int = 9
@export var walk_speed: int = 3
@export var run_speed: int = 10

#animation node names
var idle_node_name: String = "Idle"
var walk_node_name: String = "Walk"
var run_node_name: String = "Run"
var jump_node_name: String = "Jump"
var attack1_node_name: String = "Attack1"
var death_node_name: String = "Death"

#State Machine Conditions
var is_attaking: bool
var is_walking: bool
var is_running: bool
var is_dying: bool

#physics values
var direction: Vector3
var horizontal_velocity: Vector3
var aim_turn: float
var movement: Vector3
var vertial_velocity: Vector3
var movement_speed: int
var angular_acceleration: int
var acceleration: int
var just_hit: bool

@onready var camrot_h = get_node("camroot/h")

func _ready() -> void:
	pass
func _physics_process(delta: float) ->void:
	pass
