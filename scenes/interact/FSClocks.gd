extends Popup

# To lock outside input via a Control node,
# remember to set the focus mode to ALL??? Doesn't LIMIT input tho

signal clocks_finished
onready var clock_sprite = $Clocks

func _ready():
	set_process_unhandled_input(false)
	set_process_input(false)

# Remember that _input can still be called when process is the
# pause method for the node
func _input(event):
	if event.is_action_pressed("ui_accept"):
		# Account for animation resets
		if clock_sprite.frame != 7:
			clock_sprite.frame += 1
		else:
			clock_sprite.frame = 0

func _on_FSClocks_popup_hide():
	get_tree().paused = false
	emit_signal("clocks_finished", clock_sprite.frame)
	set_process_unhandled_input(false)
	set_process_input(false)

func _on_FSClocks_about_to_show():
	get_tree().paused = true
	set_process_unhandled_input(true)
	set_process_input(true)
