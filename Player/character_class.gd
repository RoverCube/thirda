class_name Character
extends Node3D

@export var max_health    : int = 150
@export var animation     : AnimationPlayer
@export var atk_animation : AnimationPlayer
@export var standing_col  : CollisionShape3D
@export var crouch_col    : CollisionShape3D
@export var hurt_box      : HurtBox
@export var can_attack    : bool = true

func play(animation_name: String, blend: float = -1) -> void:
	if animation.has_animation(animation_name): animation.play(animation_name, blend)
	else: push_error("n tem animação cara - ", animation_name)

func play_attack(animation_name: String, blend: float = -1) -> void:
	if animation.has_animation(animation_name): animation.play(animation_name, blend)
	else: push_error("mesh n tem animação cara - ", animation_name)

	if atk_animation.has_animation(animation_name): atk_animation.play(animation_name, blend)
	else: push_error("atk n tem animação cara - ", animation_name)
