extends Node2D

# signal for handling task completion -> item collection

onready var box_collision = $Area2D/CollisionShape2D
# onready var popup_scene = preload("res://scenes/interact/FSClocks.tscn")
# syntax for getting a node from another scene: /root/node_path
onready var popup_node = $CanvasLayer/OpenEnergyBox

func _ready():
	# connect the clocks instance (remember that self refers to 
	# the node the script is attached to, and the node calling connect
	# is the node w/ the signal)
	popup_node.connect("energy_finished", self, "handle_energy_finished")
	
func handle_energy_finished(penalty):
	if penalty != null:
		# turn down brightness
		GlobalEnvironment.on_brightness_changed()
		# advance global timer by penalty seconds
		UIBar.anim.advance(penalty)
		# enable player light
		if GlobalVars.current_player.to_lower() == "player":
			get_tree().get_current_scene().get("current_level").get_node("Player").get_node("KinematicBody2D").get_node("Light2D").enabled = true
		else:
			get_tree().get_current_scene().get("current_level").get_node("PlayerBed").get_node("KinematicBody2D").get_node("Light2D").enabled = true
		GlobalVars.lights_off = true
		
func _on_Area2D_area_entered(area):
	if area.get_parent().get_parent().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null

func interact():
#	popup_node.popup_cenetered()
	popup_node.popup()
	popup_node.set_global_position(Vector2(-760, -280))
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = true
