extends PlayerState

var can_switch : bool = false

func _on_start_state() -> void: 
	can_switch = false
	player.character.play("Crouch")
	player.character.standing_col.disabled = true
	player.character.crouch_col.disabled = false
	await player.character.animation.animation_finished
	can_switch = true
	player.character.play("CrouchIdle")


func _on_end_state() -> void:
	player.character.play("Uncrouch")
	player.character.standing_col.disabled = false
	player.character.crouch_col.disabled = true

func _check_change() -> void:
	if not can_switch: return
	
	# attack
	
	if player.input_crouch == false:
		
		if not is_zero_approx(player.input_axies):
			change_state.emit("walk")
		
		change_state.emit("idle")
