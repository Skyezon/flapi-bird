extends StaticBody2D

const  speed := 100
var view_port_size : Rect2

# Called when the node enters the scene tree for the first time.
func _ready():
	constant_linear_velocity = Vector2.LEFT
	view_port_size = get_viewport_rect()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(constant_linear_velocity)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	pass