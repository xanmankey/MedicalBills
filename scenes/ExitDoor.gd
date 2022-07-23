# TODO: update this

extends Node2D

signal notify_level_change
onready var anim_sprite := $Area2D/Doors
export (String) var scene_type = "static"
export (String) var next_scene = "Victory.tscn"

# DOORS
# Some doors require specific conditions
# all doors result in a change of scene

# logic: condition satisfied -> door gets opened
# logic: player enters collision -> scene switches
# It makes sense to use an area2D for doors

func _ready():
	self.connect("notify_level_change", self.get_owner(), "emit_level_changed")
	open_door()
	
# handles signals for keypad/padlock toggled or no keypad/padlock existing
func open_door():
	anim_sprite.play("Doors2")
	return

func _on_Area2D_area_entered(area):
	if area.get_parent().get_parent().name == "Player" or area.get_parent().get_parent().name == "PlayerBed":
		emit_signal("notify_level_change", next_scene, scene_type, null)

func _on_Area2D_area_exited(_area):
	pass
