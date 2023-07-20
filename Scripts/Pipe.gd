extends StaticBody2D

const  speed := 100

# Called when the node enters the scene tree for the first time.
func _ready():
	constant_linear_velocity = Vector2.LEFT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(constant_linear_velocity)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	pass
