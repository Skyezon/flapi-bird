extends Node2D

@onready var player_spawn_pos := $PlayerMarker
@onready var pipe_spawner := $PipeSpawner as PipeSpawner

@onready var hud_start_game_button :=$HUD/StartGame/StartGameButton
@onready var hud_retry_button := $HUD/GameOver/RetryButton
@onready var hud := $HUD as Hud

var score := 0

const Player := preload("res://Scenes/player.tscn")

var player_object : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	hud_start_game_button.button_up.connect(_start_game_button_up)
	hud_retry_button.button_up.connect(_on_retry_button_up)
	pipe_spawner.set_on_obstacle_passed_func(_on_obstacle_passed)

func _start_game_button_up():
	start_game()

func spawn_player():
	player_object = Player.instantiate()
	player_object.collided_with_anything.connect(_on_player_collided_with_anything)	
	player_spawn_pos.add_child(player_object)

func start_game():
	pipe_spawner.start_game()
	spawn_player()
	score = 0
	hud.set_score_text(str(score))
	
func game_over():
	pipe_spawner.game_over()
	hud.game_over()
	
func _on_player_collided_with_anything():
	game_over()

func _on_retry_button_up():
	player_object.queue_free()
	start_game()

func _on_obstacle_passed():
	increment_score()

func increment_score():
	score += 1
	hud.set_score_text(str(score))
