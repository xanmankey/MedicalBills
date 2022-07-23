extends Popup

signal safe_finished

export var num_1 = 2
export var num_2 = 3
export var num_3 = 5
onready var num_sprites = [$SafeNum1, $SafeNum2, $SafeNum3]
onready var safe_open = $SafeWithoutFlashlight
var finished = false
var sprite_num = 0

func _ready():
	safe_open.hide()
	set_process_unhandled_input(false)
	set_process_input(false)

# Remember that _input can still be called when process is the
# pause method for the node
func _input(event):
	# check if correct number combination (at ANY point to *hopefully avoid confusion)
	if num_sprites[0].frame == num_1 and num_sprites[1].frame == num_2 and num_sprites[2].frame == num_3:
		# if the combo is correct, show the safe
		safe_open.show()
		# and set a var so collision detection can be disabled
		# on signal
		finished = true
	# left and right for switching between numbers
	# (w/ min and max accounted for)
	if event.is_action_pressed("ui_left"):
		# revert color
		num_sprites[sprite_num].modulate = Color("#ffffff")
		sprite_num -= 1
		if sprite_num == -1:
			sprite_num = 2
		# modulate color
		num_sprites[sprite_num].modulate = Color("#ADD8E6")
	if event.is_action_pressed("ui_right"):
		num_sprites[sprite_num].modulate = Color("#ffffff")
		sprite_num += 1
		if sprite_num == 3:
			sprite_num = 0
		num_sprites[sprite_num].modulate = Color("#ADD8E6")
	if event.is_action_pressed("ui_up"):
		if num_sprites[sprite_num].frame == 9:
			num_sprites[sprite_num].frame = 0
		else:
			num_sprites[sprite_num].frame += 1
	if event.is_action_pressed("ui_down"):
		if num_sprites[sprite_num].frame == 0:
			num_sprites[sprite_num].frame = 9
		else:
			num_sprites[sprite_num].frame -= 1

func _on_FSNumberSafe_popup_hide():
	get_tree().paused = false
	emit_signal("safe_finished", finished)
	set_process_unhandled_input(false)
	set_process_input(false)

func _on_FSNumberSafe_about_to_show():
	set_process_unhandled_input(true)
	set_process_input(true)
	num_sprites[sprite_num].modulate = Color("#ADD8E6")
