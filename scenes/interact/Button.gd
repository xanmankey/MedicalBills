extends Node2D

onready var red_button = $Area2D/Redbutton
onready var green_button = $Area2D/Greenbutton
onready var collision = $Area2D/CollisionShape2D
onready var static_collision = $Area2D/StaticBody2D/CollisionShape2D

func _ready():
	# Unfortunately I'm doing a lot of manual connections here;
	# at least they're sturdy, but it's not very dynamic
	red_button.visible = false
	green_button.visible = false
	collision.disabled = true
	static_collision.disabled = true
	
func enable_button():
	# Functionality for enabling a key: 
	# visibility
	red_button.visible = true
	# and collision detection
	collision.disabled = false
	static_collision.disabled = false
