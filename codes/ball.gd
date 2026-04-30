extends CharacterBody2D
class_name  Ball

const s_SPEED = 300.0
var speed = s_SPEED
var move_dir = Vector2(-1,0)
var currently_active = false

func _physics_process(delta: float) -> void:
	if !currently_active:return
	
	velocity = move_dir * speed
	
	var did_ball_collided = move_and_slide()
	if did_ball_collided:
		
		#move_dir.bounce(get_last_slide_collision().get_normal())
		#or this way works too
		move_dir.y *= -1
		

func bounce_dif_dirs(paddle_y_pos,paddle_height):
	var new_move_dir = (global_position.y - paddle_y_pos)/(paddle_height/2.0)
	move_dir.y = new_move_dir
	move_dir.x *= -1
	speed += 140

func reset_ball(desired_location):	
	global_position = desired_location
	move_dir.x = [1,-1].pick_random()
	move_dir.y = randf()*[1,-1].pick_random()
	speed = s_SPEED
	currently_active = false
