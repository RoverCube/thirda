extends PlayerState

func _check_change() -> void:
	if not is_zero_approx(player.input_axies):
		change_state.emit("walk")
	
