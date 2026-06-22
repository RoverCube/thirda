extends PlayerState

var burst          : float = 10.0
var gravity        : float = 20.0
var fall_bost      : float = 60.0

var can_change : bool = false

func _on_start_state() -> void:
	can_change = false
	player.character.play("JumpSquat", 0.5)
	await player.character.animation.animation_finished
	player.velocity.y += burst
	player.character.play("Jump")
	can_change = true
func _on_end_state() -> void:
	player.velocity = Vector3.ZERO

func _update_physics(delta: float) -> void:
	player.velocity.y -= gravity * delta
	if player.velocity.y < 0:
		player.velocity.y -= fall_bost * delta

func _check_change() -> void:
	if player.is_on_floor() and can_change:
		if not is_zero_approx(player.input_axies):
			change_state.emit("walk")
		
		change_state.emit("idle")
