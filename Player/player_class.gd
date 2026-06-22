class_name Player
extends CharacterBody3D

@onready var buffer_timer: Timer = $JumpBufferTimer
@onready var main  : Main = $"../.."
@export var device : int = 1
var input_axies    : float = 0
var max_speed      : float = 5
var aceleration    : float = 8
var deceleration   : float = 12
var gravity        : float = 20.0
var fall_bost      : float = 60.0
var jump_force     : float = 8.0


var character    : Character

@onready var super_timer : Timer = $SuperTimer
@export var health_bar   : TextureProgressBar
@export var super_bar    : TextureProgressBar
var health               : int
var max_health           : int
var super_charge         : int = 0
var super_active         : bool = false

var is_crouched : bool = false:
	set(new):
		if new != is_crouched:
			if new == true:
				character.play("Crouch")
			else:
				character.play("Uncrouch")
		is_crouched = new

func _ready() -> void:
	max_health = character.max_health
	health = max_health
	
	
	character.hurt_box.got_damaged.connect(_on_get_hurt)

func input_name(a: String) -> String:
	return str(device,a)

func _physics_process(delta: float) -> void:
# Grabity
	if is_on_floor() == false:
		if velocity.y < 0:
			velocity.y -= fall_bost * delta
		else:
			velocity.y -= gravity * delta
# Walk
	if not is_crouched:
		input_axies = Input.get_axis(input_name("Left"),input_name("Right"))
	else:
		input_axies = 0
	if is_zero_approx(input_axies):
		velocity.x = lerpf(velocity.x, input_axies * max_speed, deceleration * delta)
	else:
		velocity.x = lerpf(velocity.x, input_axies * max_speed, aceleration * delta)
		character.play("WalkFront")

# rotation
	if input_axies != 0:
		character.rotation_degrees.y = ceili(input_axies) * 90
	
# Jump
	if Input.is_action_just_pressed(input_name("Up")):
		jump()
	if is_on_floor() and not buffer_timer.is_stopped():
		velocity.y += jump_force
# Crouch
	if is_on_floor():
		is_crouched = Input.is_action_pressed(input_name("Down"))


# Super Toggle
	if Input.is_action_just_pressed(input_name("Super")):
		super_active = true
		super_timer.start()

# Crouched Attack
	if character.can_attack:
		if is_crouched:
			if Input.is_action_just_pressed(input_name("LightPunch")) or Input.is_action_just_pressed(input_name("HeavyPunch")):
				character.crouch_punch()
			if Input.is_action_just_pressed(input_name("LightKick")) or Input.is_action_just_pressed(input_name("HeavyKick")):
				character.crouch_kick()
	# Normal Attack
		else:
			attack("LightPunch", character.light_punch, character.super_light_punch)
			attack("HeavyPunch", character.heavy_punch, character.super_heavy_punch)
			attack("LightKick", character.light_kick, character.super_light_kick)
			attack("HeavyKick", character.heavy_kick, character.super_heavy_kick)
	# Grab
			if Input.is_action_just_pressed(input_name("Grab")):
				character.grab()

	move_and_slide()

func attack(attack_name: String, normal_attack: Callable, super_attack: Callable) -> void:
	if Input.is_action_just_pressed(input_name(attack_name)):
		if super_active:
			super_attack.call()
			super_active = false
			return
		normal_attack.call()

func _on_get_hurt(hit: HitBox):
	if hit.auto_freeze:
		main.freeze(0,0.005 * hit.damage)
	
	health -= hit.damage
	super_active = false
	
	health_bar.value = health

func jump() -> void:
	if is_on_floor():
		velocity.y += jump_force
		return
	else:
		buffer_timer.start()

func _on_super_timer_timeout() -> void: super_active = false
