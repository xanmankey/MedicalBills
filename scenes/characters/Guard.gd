extends KinematicBody2D

var player = null
var player_detected = false
export var speed = 20
var velocity = Vector2.ZERO
onready var home_pos = self.get_parent().get_node("Position2D")
onready var anim_sprite = $Area2D/AnimatedSprite

func _ready():
	disable()
	
func _physics_process(_delta):
	if player_detected:
		velocity = seek()
		velocity = move_and_collide(velocity)
#	else:
#		velocity = go_back()
#		velocity = move_and_collide(velocity)
		
func _process(_delta):
	AnimateGuard()
	
# for homing
func seek():
	# direction * speed = velocity
	velocity = (player.position - position).normalized() * speed
	return velocity
	
# for returning to start
func go_back():
	# direction * speed = velocity
	velocity = (home_pos.position - position).normalized() * speed
	return velocity
	
func AnimateGuard():
	if player_detected:
		if GlobalVars.lights_off:
			anim_sprite.animation = "walk"
#			anim_sprite.frame = 0
			anim_sprite.playing = true
		elif player.name == "PlayerBed":
			anim_sprite.animation = "baton_walk"
#			anim_sprite.frame = 0
			anim_sprite.playing = true
		elif player.name == "Player":
			anim_sprite.animation = "run"
#			anim_sprite.frame = 0
			anim_sprite.playing = true
	else:
		anim_sprite.animation = "idle"
#		anim_sprite.frame = 0
		anim_sprite.playing = true

func _on_Area2D_area_entered(area):
	# Enable guard homing movement
	# (unless the lights are off)
	if GlobalEnvironment.canvas.visible == false:
		if area.get_parent().get_parent().name == "Player" or area.get_parent().get_parent().name == "PlayerBed":
			player_detected = true
			player = area.get_parent().get_parent()
			enable()

func _on_Area2D_area_exited(_area):
	# Disable guard movement
	# and return to starting position
	player = null
	player_detected = false

func enable():
	set_physics_process(true)

func disable():
	set_physics_process(false)
