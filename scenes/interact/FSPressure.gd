extends Popup

# To lock outside input via a Control node,
# remember to set the focus mode to ALL??? Doesn't LIMIT input tho

signal pressure_finished
onready var pressure_sprite = $GuageDial
onready var anim = $AnimationPlayer
onready var padlock_key = $Key2
var position = 0
var rng = RandomNumberGenerator.new()

func _ready():
	anim.current_animation = "pressure"
	padlock_key.hide()
	# currently .stop(false) is used for pausing an animation
	set_process_unhandled_input(false)
	set_process_input(false)
	
# Remember that _input can still be called when process is the
# pause method for the node
func _input(event):
	if position >= 1:
		padlock_key.show()
		return
	if event.is_action_pressed("ui_accept"):
		rng.randomize()
		# Advance animation
		var num = rng.randi_range(0, 12)
		if position <= 1:
			if num != 5:
				position += 0.01
			# for variability in the animation
			else:
				if position > 0:
					position -= 0.01
	if position > 0:
		# remember to pass the true argument as well 
		# to indicate that the animation should update
		anim.seek(position, true)
	# prevent negatives
	else:
		position = 0

func _on_Pressure_popup_hide():
	get_tree().paused = false
	emit_signal("pressure_finished", position)
	set_process_unhandled_input(false)
	set_process_input(false)

func _on_Pressure_about_to_show():
	anim.seek(position, true)
	set_process_unhandled_input(true)
	set_process_input(true)
