extends Marker2D

class_name PipeSpawner

const Pipe := preload("res://Scenes/pipe.tscn")
const offset_from_middle := 100.00 # should count from viewport size
@onready var timer := $Timer

var on_obstacle_passed : Callable

var stopped_pipes : Array[Pipe]

func _on_timer_timeout():
	spawn_pipes()

func spawn_pipes():
	var pipe = Pipe.instantiate()
	var is_spawn_two := randi_range(0,1) > 0
	if !is_spawn_two:
		if randi_range(0,1) > 0:
			pipe.position.y -= offset_from_middle
			pipe.rotate(PI)
		else :
			pipe.position.y += offset_from_middle
	else :
		var pipe2 = Pipe.instantiate()
		pipe.position.y -= offset_from_middle
		pipe2.position.y += offset_from_middle
		pipe.rotate(PI)
		pipe2.get_node("Area2D").queue_free() #since only need 1 area count
		randomize_y_position(pipe2)
		add_child(pipe2)
		
	randomize_y_position(pipe)	
	if not on_obstacle_passed:
		push_error("on_obstacle_passed function not defined")
		return
	pipe.pipe_passed.connect(on_obstacle_passed)
	add_child(pipe)
		
		
func randomize_y_position(object : Node2D):
	var additional_position_y := randf_range(-offset_from_middle/2.0, offset_from_middle/2.0)
	object.position.y += additional_position_y

func game_over():
	timer.stop()
	stop_obstacles()
	
func start_game():
	timer.start()
	clear_obstacles()
	spawn_pipes()

func stop_obstacles():
	for child in get_children():
		if child.is_in_group("obstacle"):
			var pipe := child as Pipe
			stopped_pipes.append(pipe)
			pipe.stop()

func clear_obstacles():
	for pipe in stopped_pipes:
		pipe.queue_free()
	stopped_pipes.clear()

func set_on_obstacle_passed_func(function : Callable):
	on_obstacle_passed = function
	
