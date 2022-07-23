extends Node2D

onready var current_level = $Room

func _ready():
	current_level.connect("clocks_finished", "handle_clocks_finished")

func handle_clocks_finished():
	
