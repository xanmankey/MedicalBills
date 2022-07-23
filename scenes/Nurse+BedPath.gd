extends Path2D

export var speed = 400
onready var path = $PathFollow2D
onready var sprite_forward = $PathFollow2D/Nurse/StaticBody2D/Sprite/Front
onready var sprite_backward = $PathFollow2D/Nurse/StaticBody2D/Sprite/Back
var flipped = false
	
func _physics_process(delta):
	path.set_offset(path.get_offset() + speed * delta)
