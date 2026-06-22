extends PlayerState

func _on_start_state() -> void: player.character.play("Crouch")
func _on_end_state() -> void:   player.character.play("Uncrouch")

func _check_change() -> void:
	if player.character.animation_mesh.is_playing(): return
	if player.input_crouch == false:
		
		
		
		
		change_state.emit("idle")
