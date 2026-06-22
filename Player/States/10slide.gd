extends PlayerState

var time_left : float
var max_time  : float = 1.0

func _on_start_state() -> void:
	time_left = max_time
	
	player.can_turn = false
	player.character.standing_col.disabled = true
	player.character.crouch_col.disabled = false
	
	player.velocity.x *= 2
	player.character.play("Slide")

func _on_end_state() -> void:
	player.can_turn = true
	player.character.standing_col.disabled = false
	player.character.crouch_col.disabled = true

func _update_physics(delta: float) -> void:
	time_left -= delta

func _check_change() -> void:
	if time_left <= 0:
		change_state.emit("idle")
