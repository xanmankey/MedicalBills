extends Node2D

# signal for handling task completion -> item collection
signal task_completed

onready var guage_finished = $Area2D/GuageFinished
onready var pressure_collision = $Area2D/CollisionShape2D
# onready var popup_scene = preload("res://scenes/interact/FSClocks.tscn")
# syntax for getting a node from another scene: /root/node_path
onready var popup_node = $CanvasLayer/FSPressure
# lock
onready var pressure_padlock_key = $Area2D/PadlockKey
# Event bus
# player -> clock + input -> disable player input
# input -> animation frame changed -> play audio fx

func _ready():
	# connect the clocks instance (remember that self refers to 
	# the node the script is attached to, and the node calling connect
	# is the node w/ the signal)
	popup_node.connect("pressure_finished", self, "handle_pressure_finished")
	self.connect("task_completed", pressure_padlock_key, "enable_key")
	guage_finished.hide()
	
func handle_pressure_finished(pressure):
	if pressure >= 1:
		guage_finished.show()
		# disabling functionality once the puzzle has been solved
#		clock_collision.set_deffered("disabled", true) 
		pressure_collision.disabled = true
		emit_signal("task_completed")

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
