extends Node2D



onready var score: int = 0
enum e_color {PINK = 0, GREEN = 1, YELLOW = 2, BLUE = 3 }
enum b_color {PINK = 818, GREEN = 763, YELLOW = 709, BLUE = 656 }

onready var current_color = e_color.PINK
onready var tab_bricks = [0,0,0,0,0,0,0,0]
onready var life = 5
onready var shake_screen = false
onready var speed_range_from : float = 25.0
onready var speed_range_to : float = 50.0


func play_boum()-> void:
	$snd_Boum.play()

func play_vanish()-> void:
	$snd_Vanish.play()

func play_game_over()-> void:
	$snd_GameOver.play()

func play_blop()-> void:
	$snd_Blop.play()

func play_ding_bounce()-> void:
	$snd_Ding_Bounce.play()

func play_hurt()-> void:
	$snd_Hurt.play()

func play_switch_ship()->void:
	$snd_Switch_Ship.play()
