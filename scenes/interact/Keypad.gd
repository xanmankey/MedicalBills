extends Node2D

signal keypad_enabled

onready var off_keypad = $Area2D/OffKeypad

# Called when the node enters the scene tree for the first time.
#func _ready():
#	self.connect("keypad_enabled", self.get_parent(), "handle_keypad_enabled")

func _on_Area2D_area_entered(_area):
	GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null
	
func interact():
	var keypad = GlobalVars.found_items.find("Keycard")
	if keypad != -1:
		off_keypad.hide()
		emit_signal("keypad_enabled")
