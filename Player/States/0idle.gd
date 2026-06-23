extends PlayerState

func _on_start_state() -> void:
	player.character.play("Idle", 0.15)
	player.velocity = Vector3.ZERO

func _check_change() -> void:
	if not is_zero_approx(player.input_axies):
		change_state.emit("walk")
	if player.input_crouch:
		change_state.emit("crouch")
	if player.input_jump:
		change_state.emit("jump")
	generic_to(5) # Attack
	
	
