extends Path2D

export var speed = 375
onready var path = $PathFollow2D
onready var sprite_forward = $PathFollow2D/Nurse_Bed/StaticBody2D/Sprite/Front
#onready var sprite_backward = $PathFollow2D/Nurse_Bed/StaticBody2D/Sprite/Back
var flipped = false

func _ready():
	set_process(true)
	
func _physics_process(delta):
	path.set_offset(path.get_offset() + speed * delta)

func _process(_delta):
	AnimationLoop()
		
func AnimationLoop():
	if path.unit_offset > 0.5:
		sprite_forward.flip_v = true
	else:
		sprite_forward.flip_v = false
