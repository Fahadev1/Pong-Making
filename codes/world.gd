extends Node2D


var game_size = Vector2(1920,1080)
var Center_point = game_size/2.0
var ScoreLeft = 0
var ScoreRight = 0
var FinalScore = 10


@onready var detection_left: Area2D = $detection_left
@onready var detection_right: Area2D = $detection_right
@onready var ball: Ball = $Ball
@onready var start_timer: Timer = $Timer
@onready var hud: Control = $CanvasLayer/HUD





func _ready():
	
	detection_left.Ball_collided_with_me.connect(_signal_worked)
	detection_right.Ball_collided_with_me.connect(_signal_worked)
	
	
	reset_all_game()



func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("restart"):
		reset_all_game()
	if ScoreLeft == FinalScore || ScoreRight == FinalScore:
		ScoreLeft = 0
		ScoreRight = 0
		reset_all_game()

func _draw() -> void:
	var screen_upper_midpoint = Vector2(game_size.x/2.0, 0)
	var screen_lower_midpoint = Vector2(game_size.x/2.0, game_size.y)
	draw_dashed_line(screen_upper_midpoint, screen_lower_midpoint ,Color.WHITE,2.0,7.0,true,)

func reset_all_game():
	reset_round()
	hud.reset_score()


func reset_round():
	ball.reset_ball(Center_point)
	start_timer.start()
	await start_timer.timeout
	ball.currently_active = true

func _signal_worked(is_left_paddle):
	reset_round()
	if is_left_paddle:
		ScoreRight += 1 
		hud.updating_score(ScoreLeft,ScoreRight)
	else:
		ScoreLeft += 1
		hud.updating_score(ScoreLeft,ScoreRight)
		
	
	
