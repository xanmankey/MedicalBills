extends Node

signal brightness_changed(value)

func toggle_fullscreen(value):
	OS.window_fullscreen = value
	# Saving the data after updating it
	Save.data.fullscreen = value
	Save.save_data()
	
func change_brightness(value):
	emit_signal("brightness_changed", value)

func change_master_volume(vol):
	AudioServer.set_bus_volume_db(0, vol)
	Save.data.master_volume = vol
	Save.save_data()
	
func change_music_volume(vol):
	AudioServer.set_bus_volume_db(1, vol)
	Save.data.music_volume = vol
	Save.save_data()
	
func change_sfx_volume(vol):
	AudioServer.set_bus_volume_db(0, vol)
	Save.data.sfx_volume = vol
	Save.save_data()
