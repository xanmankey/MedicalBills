extends Node2D

signal notify_level_change

var door_open := true
onready var anim_sprite := $Area2D/Doors
export (String) var scene_type = "gameplay"
export (String) var next_scene = "Hallway.tscn"
onready var keypad = $Keypad

# DOORS
# Some doors require specific conditions
# all doors result in a change of scene

# logic: condition satisfied -> door gets opened
# logic: player enters collision -> scene switches
# It makes sense to use an area2D for doors

func _ready():
	self.connect("notify_level_change", self.get_owner(), "emit_level_changed")
	if keypad != null:
		keypad.connect("keypad_enabled", self, "handle_keypad_enabled")
		door_open = false

# handles signals for keypad/padlock toggled or no keypad/padlock existing
func open_door():
	anim_sprite.play("Doors1")
	return

func _on_Area2D_area_entered(area):
	if area.get_parent().get_parent().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null
	
func handle_keypad_enabled():
	door_open = true
	
func interact():
	if door_open:
		print("interacting")
		open_door()
		yield(anim_sprite, "animation_finished")
		# Change for each scene
		emit_signal("notify_level_change", next_scene, scene_type, self)
