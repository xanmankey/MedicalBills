extends Popup

signal level_changed
export (String) var scene_type = "level"

func _ready():
	self.disable_input()

# Pause
func _input(event):
	# Accessing value via tree rather than autoloading to ensure that pausingONLY happens during gameplay
	# Remember that this needs to be accounted for in other scenes
	# TODO: I need to check if ui_cancel + no current popups
	if event.is_action_pressed("ui_end"):
		get_tree().paused = not get_tree().paused
		self.popup()

func _on_Resume_pressed():
	var pause_state = not get_tree().paused
	get_tree().paused = pause_state
	visible = pause_state
	
func _on_Settings_pressed():
	emit_signal("level_changed", "Settings.tscn", scene_type)

func _get_scene_type():
	return scene_type
	
func disable_input():
	print("disabling")
	set_process_input(false)
	
func enable_input():
	print("enabling")
	set_process_input(true)
