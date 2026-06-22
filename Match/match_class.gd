class_name Match
extends Node

var main              : Main
@export var camera    : Camera
@onready var health_1 : TextureProgressBar = $HUD/Timer/Health1
@onready var super_1  : TextureProgressBar = $HUD/Timer/Super1
@onready var health_2 : TextureProgressBar = $HUD/Timer/Health2
@onready var super_2  : TextureProgressBar = $HUD/Timer/Super2
@onready var timer    : Timer = $HUD/Timer/Time/Timer
