extends Popup

# Video
onready var fullscreen_button := $TabContainer/Video/MarginContainer/GridContainer/FullscreenButton
#onready var brightness_slider := $TabContainer/Video/MarginContainer/GridContainer/BrightnessSlider

# Audio
onready var master_volume := $TabContainer/Audio/MarginContainer/GridContainer/MasterVolume
onready var music_volume := $TabContainer/Audio/MarginContainer/GridContainer/MusicVolume
onready var sfx_volume := $TabContainer/Audio/MarginContainer/GridContainer/SFXVolume

# Gameplay
# Just displaying the controls normally, no interactivity

func _ready():
	# Load default settings into the gui; this only calls when the settings scene
	# is loaded though, so make sure to instance it in your main title screen!
	fullscreen_button.pressed = Save.data.fullscreen
	# Note that .select doesn't trigger the pressed signal, so you do need
	# to call the changed function manually the first time loading settings
#	brightness_slider.value = Save.data.brightness
	
	master_volume.value = Save.data.master_volume
	music_volume.value = Save.data.music_volume
	sfx_volume.value = Save.data.sfx_volume

# For calling all the functions to update settings
func _on_FullscreenButton_toggled(button_pressed):
	GlobalSettings.toggle_fullscreen(button_pressed)


func _on_MasterVolume_value_changed(value):
	GlobalSettings.change_master_volume(value)


func _on_MusicVolume_value_changed(value):
	GlobalSettings.change_music_volume(value)


func _on_SFXVolume_value_changed(value):
	GlobalSettings.change_sfx_volume(value)
