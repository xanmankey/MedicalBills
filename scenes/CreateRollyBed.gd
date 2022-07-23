extends Node2D

onready var popup_node = $CanvasLayer/MountBedCutscene

# TODO: handle motor switch
# if GlobalVars.lights_off: turn on light for playerbed

func _on_Area2D_area_entered(_area):
	var motor = GlobalVars.found_items.find("motor")
	if motor != -1:
		GlobalVars.found_items.remove("motor")
		popup_node.play_cutscene()

func _on_Area2D_area_exited(area):
	pass # Replace with function body.
