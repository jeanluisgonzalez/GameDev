class_name InventorySlot
extends PanelContainer

@export var type: ItemData.Type

func _init(t: ItemData.Type, cms:Vector2) -> void:
	type = t
	custom_minimum_size = cms

func _can_drop_data(at_position: Vector2, data:Variant)-> bool:
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	pass

func _physics_process(delta:float) ->void:
	#check for equipment and adjust stats
	pass

func _gui_input(event: InputEvent) -> void:
	pass
