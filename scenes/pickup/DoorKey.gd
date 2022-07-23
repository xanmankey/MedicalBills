extends Node2D

# A script for handling the task_completed signal.
onready var key = $Area2D/Key4
onready var collision = $Area2D/CollisionShape2D

func _ready():
	# Unfortunately I'm doing a lot of manual connections here;
	# at least they're sturdy, but it's not very dynamic
	key.visible = false
	collision.disabled = true

func enable_key():
	# Functionality for enabling a key: 
	# visibility
	key.visible = true
	# and collision detection
	collision.disabled = false
