extends Node2D

# I want the button to update on push, so I'm specifically sending
# the press_button signal (originally from player)
signal task_completed

onready var toy_finished = $Area2D/BalltoyFinished
onready var toy_collision = $Area2D/CollisionShape2D
onready var static_collision = $Area2D/StaticBody2D/CollisionShape2D
# button
onready var toy_button = $Area2D/Button
var finished = false

func _ready():
	# connect the clocks instance (remember that self refers to 
	# the node the script is attached to, and the node calling connect
	# is the node w/ the signal)
	self.connect("task_completed", toy_button, "enable_button")
	toy_finished.hide()
	
func handle_toy_finished():
	if finished:
		toy_finished.show()
		toy_collision.disabled = true
		# TODO: fix this collision for the full version
		static_collision.disabled = true
		emit_signal("task_completed")

func _on_Area2D_area_entered(area):
	if area.get_owner().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null

func interact():
	var ball = GlobalVars.found_items.find("Ball")
	print(ball)
	if ball != -1:
		finished = true
		GlobalVars.found_items.remove("Ball")
		handle_toy_finished()
		
