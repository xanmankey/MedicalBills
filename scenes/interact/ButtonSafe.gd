extends Node2D

# signal for handling task completion -> item collection
signal task_completed

onready var safe = [$Area2D/Safe3Red, $Area2D/Safe2Red, $Area2D/Safe1Red, $Area2D/SafeWithoutFlashlight]
onready var flashlight = $Area2D/SafeWithoutFlashlight/Flashlight
onready var door_key = $Area2D/SafeWithoutFlashlight/DoorKey

func _ready():
	# connect the clocks instance (remember that self refers to 
	# the node the script is attached to, and the node calling connect
	# is the node w/ the signal)
	self.connect("task_completed", flashlight, "enable_flashlight")
	self.connect("task_completed", door_key, "enable_key")
#	GlobalVars.connect("update_safe_sprite", self, "handle_safe_sprite")

func handle_safe_sprite(buttons_pressed, green_button):
	match buttons_pressed:
		1:
			safe[buttons_pressed - 1].hide()
			# show original button
			green_button.show()
		2:
			safe[buttons_pressed - 1].hide()
			green_button.show()
		3: 
			safe[buttons_pressed - 1].hide()
			green_button.show()
			emit_signal("task_completed")
		"":
			return

#func _on_Area2D_area_entered(area):
#	GlobalVars.interact = self
#
#func _on_Area2D_area_exited(area):
#	GlobalVars.interact = null 
#
#func interact():
#	if safe.last().visible == true:
#		emit_signal("task_completed")
