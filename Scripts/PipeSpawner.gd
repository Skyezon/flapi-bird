extends Marker2D

const Pipe := preload("res://Scenes/pipe.tscn")
const offset_from_middle := 100 # should count from viewport size

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
		randomize_y_position(pipe2)
		add_child(pipe2)
		
	randomize_y_position(pipe)	
	add_child(pipe)
		
		
func randomize_y_position(object : Node2D):
	var additional_position_y := randi_range(-offset_from_middle/2, offset_from_middle/2)
	object.position.y += additional_position_y
	
func _on_player_collided_with_anything():
	game_over()

func _on_main_start_game():
	start_game()

func game_over():
	$Timer.stop()
	
func start_game():
	$Timer.start()
	
