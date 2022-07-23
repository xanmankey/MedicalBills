extends Node2D

var door_open := false
onready var anim := $Area2D/AnimationPlayer
signal handle_level_changed
"""
export (String) var door_type = "hospital"
export (String) var next_scene = "south"
export (String) var scene_type = "gameplay"
"""

# DOORS
# Some doors require specific conditions
# all doors result in a change of scene

# logic: condition satisfied -> door gets opened
# logic: player enters collision -> scene switches
# It makes sense to use an area2D for doors

# handles signals for keypad/padlock toggled or no keypad/padlock existing
"""
func open_door():
	door_open = true
	match door_type:
		"hospital":
			anim.play("Doors2")
		"machine":
			anim.play("Doors1")
		"":
			return

func _on_Area2D_body_entered(body):
	if door_open:
		# Change for each scene
		emit_signal("handle_level_changed", next_scene, scene_type)
"""


func _on_Area2D_area_entered(area):
	GlobalVars.interact = self

func _on_Area2D_area_exited(area):
	GlobalVars.interact = null
	
func interact():
	var key = GlobalVars.found_items.find("DoorKey")
	# if key exists, play animation, and then transition scene
	if key != -1:
		anim.play("Doors2")
		emit_signal("handle_level_changed", "Victory.tscn", "static")
		
