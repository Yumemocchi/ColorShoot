extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.play_game_over()
	$EndLabel.text = $EndLabel.text % [Global.score]



func _process(delta):
	if Input.is_action_just_pressed("reset"):
		reset()
		get_tree().change_scene("res://Screens/MainScene.tscn")

func reset():
	Global.score = 0
	Global.life = 5
	Global.current_color = Global.e_color.PINK
	Global.tab_bricks = [0,0,0,0,0,0,0,0]
