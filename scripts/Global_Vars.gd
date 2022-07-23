extends Node

# Remember: signal up, call down
# You don't need to signal on a high up autoload function
# (unless it's to a higher autoload func)

#signal update_safe_sprite

#func _ready():
## get_tree().get_current_scene().get_node("Room").get_node("ButtonSafe")
## get_tree().get_current_scene().get_node("ButtonSafe")
## TODO: rework this call
#	self.connect("update_safe_sprite", get_tree().get_current_scene().get_node("ButtonSafe"), "handle_safe_sprite")

# A script for storing items that impact other items.
# This includes keys, keycards, and the flashlight.
var found_items = []
var num_buttons_pressed = 0
var global_position = Vector2(0, 0)
var interact
var lights_off = false
var current_player = "player" # setget change_camera

# decided to use global vars for global signals as well
# a signal is emitted each time a button is pressed here,
# which then uses the event bus to redirect the signal to the button safe
func press_button(button):
	num_buttons_pressed += 1
	get_tree().get_current_scene().get("current_level").get_node("ButtonSafe").handle_safe_sprite(num_buttons_pressed, button)
#	emit_signal("update_safe_sprite", num_buttons_pressed, button)

#func change_camera(current_player):
	# enable the PlayerBed camera for the hallway scene
	# I can't access that scene using the scene tree though, 
	# because when the var is changed, the player is in the
	# motor room...
	# I could attach a camera to both players and disable it on all scenes
	# not the hallway scene instead
#	get_tree().get_current_scene().get("current_level")
