extends Node2D

signal play_audio
signal level_changed
export var scene_type = "gameplay"

# for handling basic scene structuring; 
# signal connections are handled by the sceneswitcher	
func _ready():
	self.connect("play_audio", self.get_parent(), "handle_audio_playback")
	
func emit_level_changed(next_level, next_scene_type, door):
	emit_signal("level_changed", next_level, next_scene_type, door)

func emit_audio(audio_type, playback_type, audio_name):
	emit_signal("play_audio", audio_type, playback_type, audio_name)
