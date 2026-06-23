extends PlayerState

var speed : float = 250

func _on_start_state() -> void: turn_animations()

func _update_physics(delta: float) -> void:
	turn_animations(0.5)
	
	player.velocity.x = player.input_axies * speed * delta

func _check_change() -> void:
	if is_zero_approx(player.input_axies):
		change_state.emit("idle")
	if player.input_crouch:
		change_state.emit("slide")
	if player.input_jump:
		change_state.emit("jump")
	generic_to(5) # Attack


func turn_animations(blend: float = 0.1) -> void:
	if not player.can_turn: return
	if player.is_facing_negative:
		if player.input_axies > 0:
			player.character.play("WalkBack", blend)
		else:
			player.character.play("WalkFront", blend)
	else:
		if player.input_axies > 0:
			player.character.play("WalkFront", blend)
		else:
			player.character.play("WalkBack", blend)
