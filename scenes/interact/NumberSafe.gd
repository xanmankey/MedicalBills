extends Node2D

# The base number safe; contains no button, but rather 
# another safe in the Room
# signal for handling task completion -> item collection
signal task_completed

onready var safe_open = $Area2D/SafeWithoutFlashlight
onready var safe_collision = $Area2D/CollisionShape2D
# onready var popup_scene = preload("res://scenes/interact/FSClocks.tscn")
# syntax for getting a node from another scene: /root/node_path
onready var popup_node = $CanvasLayer/FSNumberSafe
onready var button = $Area2D/Button

func _ready():
	# connect the clocks instance (remember that self refers to 
	# the node the script is attached to, and the node calling connect
	# is the node w/ the signal)
	popup_node.connect("safe_finished", self, "handle_safe_finished")
	self.connect("task_completed", button, "enable_button")
	safe_open.hide()
	
func handle_safe_finished(finished):
	if finished:
		safe_collision.disabled = true
		safe_open.show()
		button.show()
		emit_signal("task_completed")

func _on_Area2D_area_entered(area):
	if area.get_owner().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null

func interact():
#	popup_node.popup_cenetered()
	popup_node.popup()
	popup_node.set_global_position(Vector2(-1640, -1655))
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = true

func _on_FSNumberSafe_popup_hide():
	popup_node.hide()
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = false
