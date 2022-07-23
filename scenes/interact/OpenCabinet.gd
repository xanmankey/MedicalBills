extends Node2D

onready var popup_node = $CanvasLayer/OpenCabinet
onready var key = $Area2D/PadlockKey
onready var area_collision = $Area2D/CollisionShape2D

signal task_completed

func _ready():
	# disabling static collision so player collision triggers body 
	popup_node.connect("drawer_finished", self, "handle_drawer_finished")
	self.connect("task_completed", key, "enable_key")
	
func _on_Area2D_area_entered(area):
	if area.get_owner().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null

func interact():
	# on interaction (will only call if enabled),
	# popup the popup
#	popup_window = popup_scene.instance()
	popup_node.popup()
	# positioning the popup (because it doesn't want to position
	# correctly)
	popup_node.set_global_position(Vector2(-136, -424))
	# lock input to the popup temporarily (because the popup is in process pause mode)
	get_tree().paused = true

func handle_drawer_finished(counter):
	if counter > 15:
		# enable key
		emit_signal("task_completed")
		# disable area collision
		area_collision.disabled = true
	# unpause the game
	get_tree().paused = false
