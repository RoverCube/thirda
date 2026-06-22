extends PlayerState

var burst          : float = 8.0
var gravity        : float = 20.0
var fall_bost      : float = 60.0

func _on_start_state() -> void:
	player.velocity.y += burst
	player.character.play("Jump")
func _on_end_state() -> void:
	player.velocity = Vector3.ZERO

func _update_physics(delta: float) -> void:
	player.velocity.y -= gravity * delta
	if player.velocity.y < 0:
		player.velocity.y -= fall_bost * delta

func _check_change() -> void:
	if player.is_on_floor():
		if not is_zero_approx(player.input_axies):
			change_state.emit("walk")
		
		change_state.emit("idle")
