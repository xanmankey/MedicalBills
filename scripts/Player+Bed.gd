extends KinematicBody2D

# in the future, I'm going to try to outsource as much 
# functionality off of the player script as I possibly can

onready var anim = $AnimationPlayer
onready var static_collision = $CollisionShape2D
onready var collision_timer = Timer.new()
onready var light = $Light2D
export(float) var speed := 600
export(int, 0, 100) var inertia := 50
const UP_DIRCTION := Vector2.UP
var _dir := Vector2.ZERO
var _velocity := Vector2.ZERO


func _ready():
	# disabling the player
	disable_player()
	add_child(collision_timer)
	collision_timer.set_wait_time(1.5)
	collision_timer.one_shot = true
	if GlobalVars.lights_off:
		var flashlight = GlobalVars.found_items.find("Flashlight")
		if flashlight != -1:
			light.enabled = true
	# connect signals
	GlobalSignals.connect("player_changed", self, "handle_player_changed")
	if GlobalVars.current_player.to_lower() == "playerbed":
		enable_player()

# velocity and directional calculations in physics process
func _physics_process(_delta:float)->void:
	_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	_dir = _dir.normalized()
	_velocity = _dir * speed
	_velocity = move_and_slide(_velocity, UP_DIRCTION)
	
	# handling collision
	for index in get_slide_count():
		var collision = get_slide_collision(index)
#		print(collision.collider.name)
		if collision.collider.is_in_group("push"):
			collision.collider.apply_central_impulse(-collision.normal * inertia)
		# handle enemy collisions; 
		# changed when Player+Bed
		elif collision.collider.is_in_group("enemy"):
			if collision_timer.time_left == 0:
				UIBar.anim.advance(10)
				collision_timer.start()
		elif collision.collider.is_in_group("guard"):
			if collision_timer.time_left == 0:
				UIBar.anim.advance(10)
				collision_timer.start()
				
	if Input.is_action_just_pressed("ui_accept"):
		if GlobalVars.interact:
			GlobalVars.interact.interact()
	
# animation in process
func _process(_delta:float)->void:
	# animation logic (just_pressed only calls on the FIRST frame)
	if Input.is_action_just_pressed("ui_right"):
		anim.play("drive_right")
	if Input.is_action_just_pressed("ui_left"):
		anim.play("drive_left")
	if Input.is_action_just_pressed("ui_up"):
		anim.play("drive_up")
	if Input.is_action_just_pressed("ui_down"):
		anim.play("drive_down")
	
func disable_player():
	self.visible = false
	static_collision.disabled = true
	set_process(false)
	set_physics_process(false)

func enable_player():
	static_collision.disabled = false
	self.visible = true
	set_process(true)
	set_physics_process(true)

# handling player swapping.
func handle_player_changed():
	enable_player()
	self.visible = true
