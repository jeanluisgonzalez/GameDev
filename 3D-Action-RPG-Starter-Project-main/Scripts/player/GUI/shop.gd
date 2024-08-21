extends CanvasLayer
@onready var shop_item_scene: PackedScene = preload("res://Scenes/player/GUI/shop_item.tscn")
var current_item: ItemData

func _ready() -> void:
	self.hide()
	for i in Game.items:
		var shop_item_temp = shop_item_scene.instantiate()
		shop_item_temp.item_info = Game.items[i]
		print(str(shop_item_temp.item_info.item_name))
		shop_item_temp.get_node("image").texture = Game.items[i].item_texture
		get_node("shop_items").add_child(shop_item_temp)
	get_node("item_info").hide()


func _on_buy_button_pressed():
	get_node("../container/inventory").add_item(str(current_item.item_name))


func _on_close_button_pressed():
	get_tree().paused = false
	Game.shopping = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	self.hide()
