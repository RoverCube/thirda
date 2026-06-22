class_name HurtBox
extends Area3D

signal got_damaged(hit: HitBox)


func _on_area_entered(area: Area3D) -> void:
	if area is HitBox:
		got_damaged.emit(area)
