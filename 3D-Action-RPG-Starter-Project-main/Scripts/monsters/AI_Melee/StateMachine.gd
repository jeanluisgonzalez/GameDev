extends Node

var state = {
	"Idle": preload("res://Scripts/monsters/AI_Melee/IdleState.gd"),
	"Run": preload("res://Scripts/monsters/AI_Melee/RunState.gd"),
	"Attack": preload("res://Scripts/monsters/AI_Melee/AttackState.gd"),
	"Death": preload("res://Scripts/monsters/AI_Melee/DeathState.gd"),
}

func change_state(new_state: String):
	if get_child_count() !=0:
		if !("Death" in get_child(0).name):
			get_child(0).queue_free()
	if state.has(new_state):
		var state_temp = state[new_state].new()
		state_temp.name = new_state
		add_child(state_temp)
