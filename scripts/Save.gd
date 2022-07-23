extends Node

const FILEPATH = "user://settings.save"
var data = {}

func _ready():
	load_data()
	
func load_data():
	# Ensuring that a config file exists
	var file = File.new()
	if not file.file_exists(FILEPATH):
		data = {
			"fullscreen": true,
#			"brightness": 1,
			"master_volume": -10,
			"music_volume": -30,
			"sfx_volume": -30
		}
		save_data()
	file.open(FILEPATH, File.READ)
	# returns variant values from a file
	# TODO: returns NULL (I want to be able to get 
	# FULL FUNCTIONALITY for the first room (settings, 
	# pause, music, ect), then I'll continue working
	# on the rest
	data = file.get_var()
	file.close()
		
func save_data():
	var file = File.new()
	file.open(FILEPATH, File.WRITE)
	file.store_var(data)
	file.close()
