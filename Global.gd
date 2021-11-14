extends Node2D



onready var score: int = 0
enum e_color {PINK = 0, GREEN = 1, YELLOW = 2, BLUE = 3 }
onready var current_color = e_color.PINK
onready var tab_bricks = [0,0,0,0,0,0,0,0]
onready var life = 5
onready var shake_screen = false
onready var is_changing_ship: bool = false


func play_boum()-> void:
	$snd_Boum.play()

func play_vanish()-> void:
	$snd_Vanish.play()

func play_game_over()-> void:
	$snd_GameOver.play()

func play_blop()-> void:
	$snd_Blop.play()
