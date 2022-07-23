extends Node2D

# signal for handling task completion -> item collection
signal task_completed

onready var clock_finished = $Area2D/ClockFinished
onready var clock_collision = $Area2D/CollisionShape2D
# onready var popup_scene = preload("res://scenes/interact/FSClocks.tscn")
# syntax for getting a node from another scene: /root/node_path
onready var popup_node = $CanvasLayer/FSClocks
onready var clock_sprite = $Area2D/Clocks
# lock
onready var clocks_padlock_key = $Area2D/ClockFinished/PadlockKey
# Event bus
# player -> clock + input -> disable player input
# input -> animation frame changed -> play audio fx

func _ready():
	# connect the clocks instance (remember that self refers to 
	# the node the script is attached to, and the node calling connect
	# is the node w/ the signal)
	popup_node.connect("clocks_finished", self, "handle_clocks_finished")
	self.connect("task_completed", clocks_padlock_key, "enable_key")
	clock_finished.hide()
	
func handle_clocks_finished(frame):
	if frame == 3:
		# show the final gameplay clock, disable interaction
		clock_finished.show()
		# disabling functionality once the puzzle has been solved
#		clock_collision.set_deffered("disabled", true) 
		clock_collision.disabled = true
		emit_signal("task_completed")
	else:
		# maintaining animation consistency between gameplay 
		# and minigame loops
		clock_sprite.frame = frame

func interact():
#	popup_node.popup_cenetered()
	popup_node.popup()
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = true


func _on_Area2D_area_entered(area):
	if area.get_owner().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null
