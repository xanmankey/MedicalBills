extends CanvasLayer

onready var anim = $AnimationPlayer
export var scene_type = "static"
signal level_changed

# A UI timer linked to a global animation; once the animation stops 
# playing, the loss screen appears
func _ready():
	self.layer = -1
	GlobalSignals.connect("start_ui_timer", self, "start_progress_bar")
	
func start_progress_bar():
	self.layer = 1
	anim.play("progress_bar")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("level_changed", "Loss.tscn", scene_type, null)
