extends WorldEnvironment
	
onready var canvas = $CanvasModulate
#TODO: uncomment when finished (for bigger games, it's annoying to not be able to 
# test scene-by-scene; I'd like to figure out a way around this)
#onready var player_light = get_tree().get_current_scene().get("current_scene").get_node("Player").get_node("KinematicBody2D").get_node("Light2D") or null
#onready var player_light = get_tree().get_current_scene().get_node("Player").get_node("KinematicBody2D").get_node("Light2D")

func on_brightness_changed():
#	environment.adjustment_enabled = true
#	environment.adjustment_brightness = value
	canvas.show()
	#TODO: uncomment when finished (for bigger games, it's annoying to not be able to 
#	player_light.enabled = true
func return_light():
	canvas.hide()
