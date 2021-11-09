extends KinematicBody2D

var speed: float = 0.0
var velocity: Vector2 = Vector2.DOWN
onready var health: int = 1
var rng = RandomNumberGenerator.new()
var place_in_tab: int = 0
var color_brick: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	print(speed)
	if Global.score < 1000:
		speed = rng.randf_range(50.0, 100.0)
	elif Global.score > 1000 and Global.score < 3000:
		speed = rng.randf_range(150.0, 200.0)
	elif Global.score >= 3000:
		speed = rng.randf_range(250.0, 300.0)
	color_brick = rng.randf_range(0, 4)
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = color_brick

func _physics_process(delta):
	velocity = velocity.normalized() * speed
	var collide = move_and_collide(velocity*delta)
	
	if position.y-64 > get_viewport().size.y:
		if Global.life > 0:
			Global.life = Global.life - 1
		Global.play_vanish()
		Global.tab_bricks[place_in_tab] = 0
		Global.shake_screen = true		
		queue_free()
	if health == 0 :
		health = health-1
		destroy()


func take_damages(x:int):
	print("hit : "+str(x))
	health = health-x


func destroy():
	$Tween.interpolate_property(self, "scale",scale,Vector2(1.5,1.5) ,0.2,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
	$Tween.start()
	print("yield wait")
	yield($Tween,"tween_completed")
	print("yield ok")
	Global.tab_bricks[place_in_tab] = 0
	Global.score = Global.score + 100
	Global.play_blop()
	queue_free()
