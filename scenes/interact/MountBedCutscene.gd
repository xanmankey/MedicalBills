extends Popup

onready var anim = $AnimationPlayer	

func play_cutscene():
	self.popup()
	get_tree().paused = true
	anim.play("motor_cutscene")

func _on_AnimationPlayer_animation_finished(anim_name):
	# on cutscene finished, emit change player signal
	GlobalSignals.emit_signal("player_changed")
	# re-enable gameplay
	self.hide()
	get_tree().paused = false
	GlobalVars.current_player = "PlayerBed"
