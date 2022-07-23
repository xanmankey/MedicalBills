extends Popup

# To lock outside input via a Control node,
# remember to set the focus mode to ALL??? Doesn't LIMIT input tho

signal drawer_finished
onready var paper_sprite = $WrittenPaperNoBackground
onready var static_paper = $StaticPaper
onready var key = $Key2
onready var anim = $AnimationPlayer
var counter = 0
var rng = RandomNumberGenerator.new()

# Remember that _input can still be called when process is the
# pause method for the node
func _ready():
	anim.playback_speed = 2
	# disable input when popup hidden
	set_process_unhandled_input(false)
	set_process_input(false)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if counter <= 15:
			rng.randomize()
			# Advance animation
			var num = rng.randi_range(0, 2)
			if num == 0:
				anim.play("paper_left")
			else:
				anim.play("paper_right")

# for controlling animations
func _on_AnimationPlayer_animation_finished(anim_name):
	# reset animation once it's done
#	print("animation finished")
	if anim_name != "RESET":
		anim.play("RESET")
		return
	counter += 1
	if counter > 15:
		# make static paper invisible
		static_paper.hide()
		# make animated paper invisible
		paper_sprite.hide()

func _on_OpenCabinet_popup_hide():
	get_tree().paused = false
	emit_signal("drawer_finished", counter)
	# disable input when popup hidden
	set_process_unhandled_input(false)
	set_process_input(false)

func _on_OpenCabinet_about_to_show():
	# enable input when popup shows
	set_process_unhandled_input(true)
	set_process_input(true)
