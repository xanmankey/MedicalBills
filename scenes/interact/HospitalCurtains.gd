extends Node2D

onready var curtain_open = $Area2D/HospitalCurtainsTeelOpen
onready var curtain_closed = $Area2D/HospitalCurtainsTeel
onready var curtain_collision = $Area2D/CollisionShape2D
onready var static_collision = $Area2D/StaticBody2D/CollisionShape2D

func _ready():
	curtain_open.hide()
	curtain_closed.z_index = 10

func _on_Area2D_area_entered(area):
	if area.get_owner().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null

func interact():
	curtain_closed.visible = false
	curtain_open.visible = true
	curtain_open.z_index = 0
	curtain_collision.disabled = true
	static_collision.disabled = true
