extends Area2D

export var speed: float = 800
var velocity: Vector2 = Vector2.UP
var rng = RandomNumberGenerator.new()
var damages: int = 1
var color_bullet = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	rng.randomize()
	

func _physics_process(delta):
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = color_bullet
	velocity = velocity.normalized() * speed * delta
	translate(velocity)

func change_color_bullet(x):
	color_bullet = x

func _on_Bullet_body_entered(body):
	if body.is_in_group("bricks"):
		if body.color_brick == color_bullet:
			body.take_damages(damages)
			queue_free()
		else:
			print("pas la bonne couleur")
			Global.play_ding_bounce()
			velocity = velocity*-1
	else:
		print(body)



func _on_Bullet_area_entered(area):
	if area.is_in_group("ship"):
		Global.life = Global.life-1
		Global.play_hurt()
		Global.shake_screen = true
