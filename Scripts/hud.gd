extends Control

class_name Hud

@onready var game_over_display := $GameOver
@onready var start_game_display := $StartGame
@onready var score_text := $Score/ScoreLabel

func _ready():
	game_over_display.visible = false
	score_text.visible = false
	

func start_game():
	start_game_display.visible = false
	game_over_display.visible = false
	score_text.visible = true
	score_text.text = "0"


func _on_start_game_button_button_up():
	start_game()

func _on_retry_button_button_up():
	start_game()
	
	
func game_over():
	game_over_display.visible = true
	
func set_score_text(score : String):
	score_text.text = score


func _on_quit_button_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(0)
