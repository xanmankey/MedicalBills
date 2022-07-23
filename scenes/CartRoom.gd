extends Node2D

signal play_audio
signal level_changed
export var scene_type = "gameplay"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("play_audio", self.get_parent(), "handle_audio_playback")

# door emits a signal to the parent, which emits a signal to the scene switcher
# (in effect, pointless, a global scene bus is much more effective and optimized)
func emit_level_changed(next_level, next_scene_type, door):
	emit_signal("level_changed", next_level, next_scene_type, door)

func emit_audio(audio_type, playback_type, audio_name):
	emit_signal("play_audio", audio_type, playback_type, audio_name)
