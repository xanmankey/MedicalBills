extends Node2D

# The second number safe; contains a button + signal
# signal for handling task completion -> item collection
signal task_completed

onready var button = $Area2D/Button2
onready var safe_finished = $Area2D/SafeWithoutFlashlight
onready var safe_collision = $Area2D/CollisionShape2D
# onready var popup_scene = preload("res://scenes/interact/FSClocks.tscn")
# syntax for getting a node from another scene: /root/node_path
onready var popup_node = $FSNumberSafe

func _ready():
	# connect the clocks instance (remember that self refers to 
	# the node the script is attached to, and the node calling connect
	# is the node w/ the signal)
	popup_node.connect("safe_finished", self, "handle_safe_finished")
	self.connect("task_completed", button, "enable_button")
	safe_finished.hide()
	popup_node.popup()
	
func handle_safe_finished(finished):
	if finished:
		safe_collision.disabled = true
		safe_finished.show()
		button.show()
		emit_signal("task_completed")

func _on_Area2D_area_entered(area):
	GlobalVars.interact = self

func _on_Area2D_area_exited(area):
	GlobalVars.interact = null

func interact():
#	popup_node.popup_cenetered()
	popup_node.popup()
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = true

func _on_FSNumberSafe_popup_hide():
	popup_node.hide()
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = false
