class_name Main
extends Node

const MATCH_SCENE = preload("uid://bstbhtghwtxj8")
const PLAYER_SCENE = preload("uid://dhuesupipw7l1")
# Characters
const ESQUILO_SCENE = preload("res://Player/Characters/Diuk/diuk_scene.tscn")


func _ready() -> void:
	aaaaaaa(ESQUILO_SCENE.instantiate(),ESQUILO_SCENE.instantiate())
	
	

func aaaaaaa(char1: Character, char2: Character) -> void:
	var match_scene : Match = MATCH_SCENE.instantiate()
	var p1: Player = PLAYER_SCENE.instantiate()
	var p2: Player = PLAYER_SCENE.instantiate()
	
	p1.add_child(char1)
	p2.add_child(char2)
	p1.character = char1
	p2.character = char2
	p1.device = 1
	p2.device = 2
	
	match_scene.add_child(p1)
	match_scene.add_child(p2)
	
	p1.position.x = -3
	p2.position.x =  3
	p1.character.rotation_degrees.y =  90
	p2.character.rotation_degrees.y = -90
	
	match_scene.camera.player_1 = p1
	match_scene.camera.player_2 = p2
	
	add_child(match_scene)
	
	match_scene.health_1.max_value = p1.max_health
	match_scene.health_2.max_value = p2.max_health
	match_scene.health_1.value = p1.health
	match_scene.health_2.value = p2.health
	match_scene.super_1.value = p1.super_charge
	match_scene.super_2.value = p2.super_charge


func freeze(scale: float = 0, duration: float = 0.1) -> void:
	Engine.time_scale = scale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1
