extends StaticBody2D

class_name Pipe

signal pipe_passed

const  speed := 2

# Called when the node enters the scene tree for the first time.
func _ready():
	constant_linear_velocity = Vector2.LEFT * speed


func _physics_process(_delta):
	move_and_collide(constant_linear_velocity)
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	pass

func stop():
	set_physics_process(false)

func _on_area_2d_body_entered(_body):
	pipe_passed.emit()
