extends Area2D

var inp_up = "move_up"
var inp_down = "move_down"

@export var is_p1 = true
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var velocity = 0.0
var accileration = 30.0


const MAX_VEL = 13.0
const SLOW_DOWN_VALUE = 0.67
const INVISIBILE_WALL_LIMIT = 74


func _ready() -> void:
	if is_p1 == false:
		inp_up += "_p2"
		inp_down +="_p2"


func _physics_process(delta: float) -> void:
	var move_direction = 0.0
	
	move_direction = Input.get_axis(inp_up,inp_down)
	
	velocity += delta * move_direction * accileration
	velocity = clampf(velocity,-MAX_VEL,MAX_VEL)
	
	if move_direction == 0.0:
		velocity = move_toward(velocity,0.0,SLOW_DOWN_VALUE)
	global_position.y +=velocity
	global_position.y = clampf(global_position.y ,INVISIBILE_WALL_LIMIT, get_window().size.y+-INVISIBILE_WALL_LIMIT)	
	


func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		body.bounce_dif_dirs(global_position.y , collision_shape_2d.shape.get_rect().size.y)
		
