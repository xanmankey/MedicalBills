extends Sprite

onready var anim = $AnimationPlayer
onready var static_collision = $Area2D/StaticBody2D/CollisionShape2D
onready var area_collision = $Area2D/CollisionShape2D

func _on_Area2D_area_entered(area):
	if area.get_parent().get_parent().name == "PlayerBed":
		anim.play("box_destroyed")
		# disable collision to avoid replaying the animation
		area_collision.disabled = true
		static_collision.disabled = true

func _on_AnimationPlayer_animation_finished(anim_name):
	# remove the box from existence
	self.queue_free()
