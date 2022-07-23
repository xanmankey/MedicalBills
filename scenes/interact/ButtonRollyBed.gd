extends Node2D

signal press_button

onready var area_collision = $RigidBody2D/Area2D/CollisionShape2D
onready var bed_area = $RigidBody2D/Area2D
# button
onready var bed_button = $RigidBody2D/Button
var button_pressed = false

func _ready():
	# connect the clocks instance (remember that self refers to 
	# the node the script is attached to, and the node calling connect
	# is the node w/ the signal)
	self.connect("press_button", GlobalVars, "press_button")
	# disable button collision and button press detection
	bed_button.get_node("Area2D/StaticBody2D/CollisionShape2D").disabled = true
	bed_button.get_node("Area2D/CollisionShape2D").disabled = true

func _on_Area2D_area_entered(area):
	# pressing the button on entering the area
	# (which should just end up in cart physics)
	if area.get_owner().name == "Player":
		if not button_pressed:
			button_pressed = true
			emit_signal("press_button", $RigidBody2D/Button/Area2D/Greenbutton)
	
func _on_Button_visibility_changed():
	# showing the button immediately (special case)
	$RigidBody2D/Button/Area2D/Redbutton.visible = true
