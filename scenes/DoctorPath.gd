extends Path2D

export var speed = 350
onready var path = $PathFollow2D
onready var sprite_forward = $PathFollow2D/Doctor/StaticBody2D/Sprite/Front
onready var sprite_backward = $PathFollow2D/Doctor/StaticBody2D/Sprite/Back
var flipped = false
	
func _physics_process(delta):
	path.set_offset(path.get_offset() + speed * delta)

#func _process(_delta):
#	AnimationLoop()
#
#func AnimationLoop():
#	if path.unit_offset > 0.5:
#		sprite_backward.show()
#	else:
#		sprite_backward.hide()
