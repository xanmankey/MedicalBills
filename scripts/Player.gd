extends KinematicBody2D
# oftentimes the player script is on the root node for the scene, 
# and the kinematic functionality is accessed down 
# (I learned this a little too late)

onready var anim = $AnimationPlayer
onready var area_collision = $Area2D
onready var static_collision = $CollisionShape
onready var collision_timer = Timer.new()
onready var light = $Light2D
export(float) var speed := 400
# inferred
export(int, 0, 100) var inertia := 50
# static
export var enemy_penalty: int = 25
export var guard_penalty: int = 150
export var initial_direction := "Sprite/Front"
const WALL_DIRCTION := Vector2.ZERO
var _dir := Vector2.ZERO
var _velocity := Vector2.ZERO

func _ready():
	hideChildren()
	changeAnimationDuration()
	# The time between collisions
	add_child(collision_timer)
	collision_timer.set_wait_time(1.5)
	collision_timer.one_shot = true
	get_node(initial_direction).show()
	if GlobalVars.lights_off:
		var flashlight = GlobalVars.found_items.find("Flashlight")
		if flashlight != -1:
			light.enabled = true
	GlobalSignals.connect("press_button", GlobalVars, "press_button")
	GlobalSignals.connect("player_changed", self, "handle_player_changed")
	if GlobalVars.current_player.to_lower() == "playerbed":
		disable_player()
	
	
func hideChildren():
	for child in $Sprite.get_children():
		child.hide()
		
# This code COULD be used for dynamic animations; 
# I'm just using it to save a bit of time because I'm not sure how to stretch 
# out an animation properly in the AnimationPlayer
func changeAnimationDuration():
	# for animation in anim.get_animation_list():
		# animation.length = animation.current_animation_length * 3
	# alternatively, I found changing the playback speed was more effective
	anim.playback_speed = anim.playback_speed / 2

# velocity and directional calculations in physics process
func _physics_process(_delta:float)->void:
	# INFORMATION
	# The character ALWAYS flies to the left (no matter the input dir) if the game is started via the title screen, 
	# UNLESS the player sends input DURING the title screen.
	# It has nothing to do with collision, and disabling + enabling seems to prevent
	# ALL movement... 
	_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	_dir = _dir.normalized()
	_velocity = _dir * speed
	_velocity = move_and_slide(_velocity, WALL_DIRCTION, false, 4, PI/4, false)
	
	# handling collision
	# for future collision, I think a signal bus is probably a better idea
	# so I don't have to constantly do all these checks in the player code
	for index in get_slide_count():
		var collision = get_slide_collision(index)
#		print(collision.collider.name)
		if collision.collider.is_in_group("push"):
			collision.collider.apply_central_impulse(-collision.normal * inertia)
# interacting is determined via signal
#		if collision.collider.is_in_group("interact"):
#			print("interact")
		# handle enemy collisions
		# TODO: fix collisions (multiple collisions stack)
		elif collision.collider.is_in_group("enemy"):
			if collision_timer.time_left == 0:
				UIBar.anim.advance(enemy_penalty)
				collision_timer.start()
		elif collision.collider.is_in_group("guard"):
			if collision_timer.time_left == 0:
				UIBar.anim.advance(guard_penalty)
				collision_timer.start()
			
	if Input.is_action_just_pressed("ui_accept"):
		# get a list of all Area2D objects 
		# (note that get_overlapping_bodies is an Area2D object itself)
		# (also note that for get_overlapping_bodies to work, the bodies 
		# need to HAVE bodies themselves)
		if GlobalVars.interact:
			# While this seemed to work, I'm not so sure about 
			# the execution flow here; seems like an unrealistic 
			# amount of processing on this script
			GlobalVars.interact.interact()
			# return
		
		for area in area_collision.get_overlapping_areas():
			# check the group of the object
			if area.is_in_group("pickup"):
				# NOTE: started by using a node2D as an owner, 
				# now I need to keep that consistent 
				# (because I'm not quite sure about godot refactoring)
				# remove from scene, add to global settings
				# remember that the area MUST contain the sprite
				area.queue_free()
				# TODO: currently just using a name, 
				# I also want an item visualization eventually
				GlobalVars.found_items.append(area.owner.name)
			if area.is_in_group("press"):
				area.get_node("CollisionShape2D").disabled = true
				GlobalSignals.emit_signal("press_button", area.find_node("Greenbutton"))
			
# gdscript does NOT support named parameters :(
func animateDirection(just_pressed):
	if just_pressed:
		if Input.is_action_just_pressed("ui_left"):
			anim.play("walk_right")
			hideChildren()
			$Sprite/Right.show()
		if Input.is_action_just_pressed("ui_right"):
			anim.play("walk_left")
			hideChildren()
			$Sprite/Left.show()
		if Input.is_action_just_pressed("ui_up"):
			anim.play("walk_up")
			hideChildren()
			$Sprite/Back.show()
		if Input.is_action_just_pressed("ui_down"):
			anim.play("walk_down")
			hideChildren()
			$Sprite/Front.show()
	else:
		if Input.is_action_pressed("ui_left"):
			anim.play("walk_right")
			hideChildren()
			$Sprite/Right.show()
		if Input.is_action_pressed("ui_right"):
			anim.play("walk_left")
			hideChildren()
			$Sprite/Left.show()
		if Input.is_action_pressed("ui_up"):
			anim.play("walk_up")
			hideChildren()
			$Sprite/Back.show()
		if Input.is_action_pressed("ui_down"):
			anim.play("walk_down")
			hideChildren()
			$Sprite/Front.show()
	
# animation in process
func _process(_delta:float)->void:
	# animation logic (just_pressed only calls on the FIRST frame)
	# toggle sprite visibility and play animation
	if _velocity.x == 0 and _velocity.y == 0:
		# To reset any animation-resulting rotation
		anim.stop()
		anim.play("stop")
		anim.stop()
	animateDirection(true)
	if not anim.is_playing():
		animateDirection(false)
	
# While these functions work, it's more effective to just
# PAUSE EVERYTHING on static scenes	
func disable_player():
	self.visible = false
	static_collision.disabled = true
	set_process(false)
	set_physics_process(false)

func enable_player():	# For some reason, this is the only workaround
	# I could find to the problem
#	yield(get_tree().create_timer(0.3), "timeout")
	static_collision.disabled = false
	self.visible = true
	set_process(true)
	set_physics_process(true)
	
func handle_player_changed():
	self.visible = false
	disable_player()
	
# My plan for the future (not exactly optimal)
# include a player and playerbed node in each scene
# add code for disabling either node in the _ready function
# based on a global var
# and add position code based on a global var
