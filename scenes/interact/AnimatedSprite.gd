extends AnimatedSprite

# To lock outside input via a Control node,
# remember to set the focus mode to ALL??? Doesn't LIMIT input tho

signal clocks_finished

# Remember that _input can still be called when process is the
# pause method for the node
func _input(event):
	if event.is_action_pressed("ui_accept"):
		# Account for animation resets
		if self.frame != 7:
			self.frame += 1
		else:
			self.frame = 0

func _on_Clocks_popup_hide():
	get_tree().paused = false
	emit_signal("clocks_finished", self.frame)
