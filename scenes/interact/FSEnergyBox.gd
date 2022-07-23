extends Popup

# To lock outside input via a Control node,
# remember to set the focus mode to ALL??? Doesn't LIMIT input tho

signal energy_finished
onready var red = $EnergyboxUncutWires/RedWire
onready var green = $EnergyboxUncutWires/GreenWire
onready var yellow = $EnergyboxUncutWires/YellowWire
onready var red_cut = $EnergyboxUncutWires/RedWireCut
onready var green_cut = $EnergyboxUncutWires/GreenWireCut
onready var yellow_cut = $EnergyboxUncutWires/YellowWireCut
var wire_num = 0
# default:new
var color_modulations = {Color("#ff0000"): Color("#b10000"), 
	Color("#00ff53"): Color("#00bc4d"), Color("#ffff00"): Color("#d9d900")}
var cut_wires = []
var correct_order = ["red", "yellow", "green"]
var penalty

func _ready():
	set_process_unhandled_input(false)
	set_process_input(false)
	red.modulate = color_modulations[Color("#ff0000")]

# Remember that _input can still be called when process is the
# pause method for the node
func _input(event):
	if event.is_action_pressed("ui_left"):
		if wire_num == 0:
			pass
		else:
			# revert to default
			match wire_num:
				1:
					green.modulate = Color("#00ff53")
				2:
					yellow.modulate = Color("#ffff00")
			wire_num -= 1
			# modulate new wire
			match wire_num:
				0:
					red.modulate = color_modulations[Color("#ff0000")]
				1:
					green.modulate = color_modulations[Color("#00ff53")]
	if event.is_action_pressed("ui_right"):
		if wire_num == 2:
			pass
		else:
			# revert to default
			match wire_num:
				0:
					red.modulate = Color("#ff0000")
				1:
					green.modulate = Color("#00ff53")
			wire_num += 1
			# modulate new wire
			match wire_num:
				1:
					green.modulate = color_modulations[Color("#00ff53")]
				2:
					yellow.modulate = color_modulations[Color("#ffff00")]
	if event.is_action_pressed("ui_accept"):
		# hide uncut wire, show cut wire
		# also takes care of a time penalty here
		match wire_num:
			0:
				red.hide()
				red_cut.show()
				if not cut_wires.has("red"):
					cut_wires.append("red")
			1:
				green.hide()
				green_cut.show()
				if not cut_wires.has("green"):
					cut_wires.append("green")
			2:
				yellow.hide()
				yellow_cut.show()
				if not cut_wires.has("yellow"):
					cut_wires.append("yellow")
		if cut_wires.size() == 3:
			if cut_wires == correct_order:
				penalty = 0
				emit_signal("energy_finished", penalty)
			else:
				penalty = 50
				emit_signal("energy_finished", penalty)
				penalty = 0

func _on_OpenEnergyBox_popup_hide():
	get_tree().paused = false
	emit_signal("energy_finished", penalty)
	set_process_unhandled_input(false)
	set_process_input(false)
	
func _on_OpenEnergyBox_about_to_show():
	set_process_unhandled_input(true)
	set_process_input(true)
