extends PlayerState

var burst          : float = 10.0
var gravity        : float = 20.0
var fall_bost      : float = 60.0
var air_control    : float = 10.0

var can_change : bool = false

func _on_start_state() -> void:
	can_change = false
	player.character.play("JumpSquat", 0.5)
	player.can_turn = false
	
	await player.character.animation.animation_finished
	
	can_change = true
	player.velocity.y += burst
	player.character.play("Jump")
func _on_end_state() -> void:
	player.velocity = Vector3.ZERO
	player.can_turn = true

func _update_physics(delta: float) -> void:
	player.velocity.y -= gravity * delta
	if player.velocity.y < 0:
		player.velocity.y -= fall_bost * delta
	
	player.velocity.x += player.input_axies * air_control * delta

func _check_change() -> void:
	if player.is_on_floor() and can_change:
		if not is_zero_approx(player.input_axies):
			change_state.emit("walk")
		
		change_state.emit("idle")
