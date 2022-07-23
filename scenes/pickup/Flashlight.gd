extends Node2D

# A script for handling the task_completed signal.
onready var flashlight = $Area2D/Flashlight
onready var collision = $Area2D/CollisionShape2D

func _ready():
	# Unfortunately I'm doing a lot of manual connections here;
	# at least they're sturdy, but it's not very dynamic
	flashlight.visible = false
	collision.disabled = true

func enable_flashlight():
	# Functionality for enabling a key: 
	# visibility
	flashlight.visible = true
	# and collision detection
	collision.disabled = false
