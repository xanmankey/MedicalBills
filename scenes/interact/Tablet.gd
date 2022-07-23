extends Node2D

onready var tablet_loading = $Area2D/Tablet
onready var tablet_loaded = $Area2D/TabletWithWiresCut
onready var popup_node = $CanvasLayer/FSTablet

# A tablet that takes some time to turn on; goes through 3 visibility phases
# Visibility is an alternative to animated sprites; 
# it's all just testing and learning here
func _ready():
	tablet_loading.visible = false
	tablet_loaded.visible = false
	popup_node.connect("tablet_loaded", self, "handle_tablet_loaded")

func _on_Area2D_area_entered(area):
	if area.get_owner().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null
	
func interact():
	popup_node.popup()
	popup_node.set_global_position(Vector2(-797, -521))
	get_tree().paused = true

func handle_tablet_loaded(finished):
	match finished:
		0:
			tablet_loading.visible = false
			tablet_loaded.visible = false
		1:
			tablet_loading.visible = true
			tablet_loaded.visible = false
		2:
			tablet_loaded.visible = true
		"":
			return
