class_name BasePlayerState
extends RefCounted

## Called when we firest enter this state.
func enter(player: Player) ->void:
	pass

## Called when we exist a state.
func exit(player: Player) -> void:
	pass

## Called for every physics frame that we're in this state.
func update(player: Player ,delta: float) -> void:
	pass
