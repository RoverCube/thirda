class_name Player
extends CharacterBody3D

@onready var buffer_timer: Timer = $JumpBufferTimer
@onready var main  : Main = $"../.."
@export var device : int = 1

var input_axies        : float = 0.0
var input_crouch       : bool  = false
var input_jump         : bool  = false
var input_block        : bool  = false
var input_light_punch  : bool  = false
var input_strong_punch : bool  = false
var input_light_kick   : bool  = false
var input_strong_kick  : bool  = false
var input_grab         : bool  = false
var input_ultimate     : float = 0.0
#var max_speed      : float = 5
#var aceleration    : float = 8
#var deceleration   : float = 12
#var gravity        : float = 20.0
#var fall_bost      : float = 60.0
#var jump_force     : float = 8.0

var character    : Character

@onready var super_timer : Timer = $SuperTimer
var health_bar   : TextureProgressBar
var super_bar    : TextureProgressBar
var health               : int
var max_health           : int
var super_charge         : int = 0
var super_active         : bool = false

func _ready() -> void:
	max_health = character.max_health
	health = max_health
	character.hurt_box.got_damaged.connect(_on_get_hurt)

func _input(_event: InputEvent) -> void:
	input_axies = Input.get_axis(input_name("Left"),input_name("Right"))
	input_crouch = Input.is_action_just_pressed(input_name("Crouch"))
	

func input_name(a: String) -> String:
	return str(device,a)
func _on_get_hurt(hit: HitBox):
	if hit.auto_freeze:
		main.freeze(0,0.005 * hit.damage)
	
	health -= hit.damage
	super_active = false
	
	health_bar.value = health
func _on_super_timer_timeout() -> void: super_active = false
