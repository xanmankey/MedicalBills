extends Node2D

# The base number safe; contains no button, but rather 
# another safe in the Room
# signal for handling task completion -> item collection
onready var popup_node = $CanvasLayer/FSDischarge

func _ready():
	popup_node.hide()

func _on_Area2D_area_entered(area):
	if area.get_owner().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null

func interact():
#	popup_node.popup_cenetered()
	popup_node.popup()
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = true

func _on_FSDischarge_popup_hide():
	popup_node.hide()
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = false
