extends Control

#not a good pratices its better a func that is called when you hit Esc, this have to be change later
func _process(delta):
	get_node("stats_label").text ="
	Player Health: %s
	Player Attack: %s
	Player Defense: %s
	Player Level: %s
	Player EXP: %s / %s
	"% [Game.player_health, Game.player_damage, Game.player_defense, Game.player_level, Game.current_exp, Game.exp_to_next_level]
