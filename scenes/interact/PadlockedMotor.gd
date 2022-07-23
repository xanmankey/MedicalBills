extends Node2D

signal task_completed

var num_locks_removed = 0
onready var lock_1 = $Area2D/Locked
onready var lock_2 = $Area2D/Locked2
onready var lock_3 = $Area2D/Locked3
onready var locks = [lock_1, lock_2, lock_3]
onready var motor = self

func _ready():
	# Because this is being removed, the parent needs to 
	# be the key itself
	self.connect("task_completed", self.get_parent(), "enable_key")

func _on_Area2D_area_entered(area):
	if area.get_owner().name == "Player":
		GlobalVars.interact = self

func _on_Area2D_area_exited(_area):
	GlobalVars.interact = null

func interact():
	# find returns an index
	var keys = GlobalVars.found_items.find("PadlockKey")
	if num_locks_removed == 3:
		# add the motor to global vars, then remove it from the scene, 
		# revealing the door key
		GlobalVars.found_items.append("motor")
		self.queue_free()
		emit_signal("task_completed")
	if keys != -1:
		locks[num_locks_removed].queue_free()
		GlobalVars.found_items.remove(keys)
		keys = null
		num_locks_removed += 1
		return
		
