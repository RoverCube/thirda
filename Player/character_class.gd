@abstract
class_name Character
extends Node3D

@export var max_health : int = 150
@export var animation  : AnimationPlayer
@export var hurt_box   : HurtBox
@export var can_attack : bool = true

@abstract
func light_punch() -> void
@abstract
func heavy_punch() -> void
@abstract
func light_kick() -> void
@abstract
func heavy_kick() -> void

@abstract
func crouch_punch() -> void
@abstract
func crouch_kick() -> void
@abstract
func grab() -> void

@abstract
func super_light_punch() -> void
@abstract
func super_heavy_punch() -> void
@abstract
func super_light_kick() -> void
@abstract
func super_heavy_kick() -> void

func play(animation_name: String, blend: float = -1) -> void:
	if animation.has_animation(animation_name): animation.play(animation_name, blend)
	else: push_error("n tem animação cara - ", animation_name)
