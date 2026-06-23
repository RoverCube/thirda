class_name Player
extends CharacterBody3D

@onready var main  : Main = $"../.."
@export var device : int = 1


@onready var state_machine : StateMachine = $StateMachine
var other_player           : Player
var is_facing_negative     : bool
var distance               : float
var can_turn               : bool = true

var input_axies        : float = 0.0
var input_crouch       : bool  = false
var input_jump         : bool  = false
var input_block        : bool  = false
var input_light_punch  : bool  = false
var input_heavy_punch : bool  = false
var input_light_kick   : bool  = false
var input_heavy_kick  : bool  = false
var input_grab         : bool  = false
var input_ultimate     : float = 0.0

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
	input_crouch = Input.is_action_pressed(input_name("Down"))
	input_jump = Input.is_action_just_pressed(input_name("Up"))
	
	input_light_punch = Input.is_action_just_pressed(input_name("LightPunch"))
	input_heavy_punch = Input.is_action_just_pressed(input_name("HeavyPunch"))
	input_light_kick = Input.is_action_just_pressed(input_name("LightKick"))
	input_heavy_kick = Input.is_action_just_pressed(input_name("HeavyKick"))


func _physics_process(delta: float) -> void:
	move_and_slide()
	
	distance = position.x - other_player.position.x
	
	if Input.is_action_pressed(input_name("Super")):
		input_ultimate += delta
	elif Input.is_action_just_released(input_name("Super")):
		if input_ultimate < 0.2: activate_super()
		input_ultimate = 0.0
	
	
	if distance > 0: # negativo
		if not is_facing_negative: # virado pro positivo
			turn(false)
	else: # positivo
		if is_facing_negative: # virado pro negativo
			turn(true)
func turn(negative: bool) -> void:
	if not can_turn: return
	if negative:
		rotation_degrees.y =  90
		is_facing_negative = false
	else:
		rotation_degrees.y = -90
		is_facing_negative = true

func input_name(a: String) -> String:
	return str(device,a)
func _on_get_hurt(hit: HitBox):
	if hit.auto_freeze:
		main.freeze(0,0.005 * hit.damage)
	
	health -= hit.damage
	super_active = false
	
	health_bar.value = health
func _on_super_timer_timeout() -> void: super_active = false
func activate_super() -> void:
	super_active = true
	super_timer.start()
