extends Node2D


const OBJ_BULLET: Object = preload("res://Cubes/Bullet.tscn")
const OBJ_BRICK: Object = preload("res://Objects/Brick.tscn")
const SIZE_BRICK = 100

signal shake

var can_fire: bool = true
var is_ast = false
var rng = RandomNumberGenerator.new()



func check_tab_bricks():
	for i in Global.tab_bricks.size():
		if Global.tab_bricks[i] == 0:
			pop_brick((SIZE_BRICK)*(i+1), i)
			Global.tab_bricks[i]=1


func pop_brick(x:int, place:int):
	var brick = OBJ_BRICK.instance()
	brick.position = Vector2(x-SIZE_BRICK/2,-200)
	brick.place_in_tab = place
	add_child(brick)

func check_fire():
	if (Input.is_action_pressed("ui_accept") and can_fire == true):
		can_fire = false		
		var bullet = OBJ_BULLET.instance()
		bullet.change_color_bullet(Global.current_color)
		bullet.position = Vector2($Cube.position.x,$Cube.position.y-20)
		add_child_below_node($S_Background,bullet)
		yield(get_tree().create_timer(0.2), "timeout")
		can_fire = true

		
func _physics_process(delta):
	check_fire()
	check_tab_bricks()
	$L_Score.text = str(Global.score)
	if Global.life == 0:
		get_tree().change_scene("res://Screens/EndScreen.tscn")
	
	if Global.shake_screen == true:
		shake()
		Global.shake_screen = false
		


func shake():
	print("shake")
	$Camera2D.set_physics_process(true)
	# And start the timer, making the screen shake again.
	$Camera2D._shake_timer.start() # Replace with function body.
