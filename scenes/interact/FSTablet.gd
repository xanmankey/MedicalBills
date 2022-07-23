extends Popup

signal tablet_loaded

onready var tablet_loading = $Tablet
onready var red_wire = $Tablet/RedWireCut
onready var green_wire = $Tablet/GreenWireCut
onready var yellow_wire = $Tablet/YellowWireCut
var finished = 0

# A tablet that takes some time to turn on; goes through 3 visibility phases
# Visibility is an alternative to animated sprites; 
# it's all just testing and learning here
func _ready():
	tablet_loading.visible = false
	set_process_unhandled_input(false)
	set_process_input(false)
	
# order is red, yellow, green
func wait_and_load_sprites():
	yield(get_tree().create_timer(2.0), "timeout")
	tablet_loading.visible = true
	finished = 1
	yield(get_tree().create_timer(4.0), "timeout")
	red_wire.show()
	yield(get_tree().create_timer(0.5), "timeout")
	red_wire.hide()
	yellow_wire.show()
	yield(get_tree().create_timer(0.5), "timeout")
	yellow_wire.hide()
	green_wire.show()
	yield(get_tree().create_timer(0.3), "timeout")
	green_wire.show()
	
func _on_Tablet_popup_hide():
	get_tree().paused = false
	emit_signal("tablet_loaded", finished)
	set_process_unhandled_input(false)
	set_process_input(false)

func _on_Tablet_about_to_show():
	wait_and_load_sprites()
	set_process_unhandled_input(true)
	set_process_input(true)
