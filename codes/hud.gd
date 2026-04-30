extends Control
@onready var left_points: Label = $LeftPoints
@onready var right_points: Label = $RightPoints


func updating_score(left,right):
	left_points.text = str(left)
	right_points.text = str(right)
	
func reset_score():
	left_points.text = "0"
	right_points.text= "0"	
