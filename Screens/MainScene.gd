extends Node2D


const OBJ_BULLET: Object = preload("res://Ship/Bullet.tscn")
const OBJ_BRICK: Object = preload("res://Objects/Brick.tscn")
const SIZE_BRICK = 100

signal shake

var can_fire: bool = true
var is_ast = false
var rng = RandomNumberGenerator.new()

onready var _score := $Labels/L_Score
onready var _life := $Labels/L_Life
onready var _speed_timer := $SpeedTimer



func _ready():
	_speed_timer.start()

func check_tab_bricks():
	for i in Global.tab_bricks.size():
		if Global.tab_bricks[i] == 0:
			pop_brick((SIZE_BRICK)*(i+1), i)
			Global.tab_bricks[i]=1


func pop_brick(x:int, place:int):
	var brick = OBJ_BRICK.instance()
	brick.position = Vector2(x-SIZE_BRICK/2,-200)
	brick.place_in_tab = place
	add_child_below_node($S_Background,brick)
#	add_child(brick)

func check_fire():
	if (Input.is_action_pressed("ui_accept") and can_fire == true):
		can_fire = false		
		var bullet = OBJ_BULLET.instance()
		bullet.change_color_bullet(Global.current_color)
		bullet.position = Vector2($Ship.position.x,$Ship.position.y-60)
		add_child_below_node($S_Background,bullet)
		yield(get_tree().create_timer(0.2), "timeout")
		can_fire = true


func _physics_process(delta):
	check_fire()
	check_tab_bricks()
	check_current_color_cursor()
	_score.text = str(Global.score)
	_life.text = str(Global.life)
	if Global.life == 0:
		get_tree().change_scene("res://Screens/EndScreen.tscn")


	if Global.shake_screen == true:
		shake()
		Global.shake_screen = false



func check_current_color_cursor():
	if Global.current_color == Global.e_color.PINK:
		$Cursor.position.y = Global.b_color.PINK
	elif  Global.current_color == Global.e_color.BLUE:
		$Cursor.position.y = Global.b_color.BLUE
	elif  Global.current_color == Global.e_color.YELLOW:
		$Cursor.position.y = Global.b_color.YELLOW
	elif  Global.current_color == Global.e_color.GREEN :
		$Cursor.position.y = Global.b_color.GREEN

func shake():
	print("shake")
	$Camera2D.set_physics_process(true)
	# And start the timer, making the screen shake again.
	$Camera2D._shake_timer.start() # Replace with function body.


func _on_SpeedTimer_timeout():
	Global.speed_range_from = Global.speed_range_from + 25.0
	Global.speed_range_to = Global.speed_range_to + 25.0
	var new_label = Label.new()
	new_label.text = "speed up !!!"
	add_child(new_label)
	# lorsque le speed timer arrive au bout
	# augmenter la vitesse de tombée des tuiles
	# augmenter la vitesse de la musique
	# afficher le  speed up à l'écran
