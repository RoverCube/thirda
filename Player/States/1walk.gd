extends PlayerState

var speed : float = 250

func _on_start_state() -> void:
	player.character.play("WalkFront")


func _update_physics(delta: float) -> void:
	player.velocity.x = player.input_axies * speed * delta
	
	player.move_and_slide()

func _check_change() -> void:
	if is_zero_approx(player.input_axies):
		change_state.emit("idle")
	if player.input_crouch:
		change_state.emit("crouch")
