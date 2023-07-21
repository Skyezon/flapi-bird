extends CharacterBody2D

class_name Player

signal collided_with_anything

const JUMP_VELOCITY := -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var collided_status := false

func _physics_process(delta):
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	
	if is_on_wall() or is_on_floor():
		on_collide_with_anything()

	move_and_slide()
	
func on_collide_with_anything():
	if collided_status :
		print("still collided")
		return
	collided_with_anything.emit()
	set_physics_process(false)
	
	

