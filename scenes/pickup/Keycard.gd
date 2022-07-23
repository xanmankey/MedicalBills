extends Node2D

func _on_Area2D_area_entered(area):
	if area.get_parent().get_parent().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null

func interact():
	pass
