extends Node

var items:Dictionary = {
	"Long Sword": preload("res://Scenes/player/GUI/Inventory/long_sword.tres"),
	"Iron Sword": preload("res://Scenes/player/GUI/Inventory/iron_sword.tres"),
	"Small Potion": preload("res://Scenes/player/GUI/Inventory/small_potion.tres"),
	"Iron Armor": preload("res://Scenes/player/GUI/Inventory/iron_body.tres"),
	
}
var gold: int = 100
var player_health: int = 5
var player_health_max: int = 5
var right_hand_equipped: ItemData
var body_equipped: ItemData

var player_damage: int = 0
var player_defense: int = 0

var current_exp: int = 0
var exp_to_next_level: int = 100
var player_level: int = 1

var shooping: bool = false

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
func _process(delta):
	player_damage = right_hand_equipped.item_damage + body_equipped.item_damage
	player_defense = body_equipped.item_defense

func heal_player(health: int) -> void:
	pass
