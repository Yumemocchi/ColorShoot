extends KinematicBody2D

# Declare member variables here. Examples:
export var speed: float = 600
var velocity: Vector2 = Vector2()
var is_in_rotation: bool = false


func get_input():
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

	if Input.is_action_just_pressed("ui_up") and !is_in_rotation:
		is_in_rotation = true
		switch_color()

		$Tween.interpolate_property(self, "rotation", rotation, rotation+deg2rad(90.0), 0.2, Tween.CONNECT_ONESHOT,Tween.EASE_IN_OUT,0.0)
		$Tween.start()

		yield($Tween,"tween_completed")
		is_in_rotation = false
		
	if Input.is_action_just_pressed("ui_down") and !is_in_rotation:
		is_in_rotation = true
		back_color()
		$Tween.interpolate_property(self, "rotation", rotation, rotation-deg2rad(90.0), 0.2, Tween.CONNECT_ONESHOT,Tween.EASE_IN_OUT,0.0)
		$Tween.start()
		yield($Tween,"tween_completed")
		is_in_rotation = false

	velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	

func switch_color()->void:
	if (Global.current_color == 3):
		Global.current_color = 0
	else:
		Global.current_color = Global.current_color +1


func back_color()->void:
	if (Global.current_color == 0):
		Global.current_color = 3
	else:
		Global.current_color = Global.current_color -1
