class_name Camera
extends Camera3D

@export var player_1 : Player
@export var player_2 : Player



func _process(_delta: float) -> void:
	var distance: float = abs(player_1.position.x - player_2.position.x)
	position.x = (player_1.position.x + player_2.position.x) / 2
	
	position.z = clamp(distance / 2, 3, 5)
