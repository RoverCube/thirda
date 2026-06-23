extends PlayerState

@export var attack_name : String

func _on_start_state() -> void:
	player.character.play_attack(attack_name, 0.2)
	await player.character.atk_animation.animation_finished
	change_state.emit("idle")

func _generic_change(self_state: State) -> void:
	if player.input_light_punch:
		attack_name = "LightPunch"
		self_state.change_state.emit("Attack")
	if player.input_heavy_punch:
		attack_name = "HeavyPunch"
		self_state.change_state.emit("Attack")
	
	if player.input_light_kick:
		attack_name = "LightKick"
		self_state.change_state.emit("Attack")
	if player.input_heavy_kick:
		attack_name = "HeavyKick"
		self_state.change_state.emit("Attack")
