extends KinematicBody2D



#Physics Variables
export var speed = 190
export var gravity = 20
export var jump_power = -500
const FLOOR = Vector2(0,-1)
var velocity = Vector2()

#State Variables
var on_ground = false #Variable that I may be able to replace with is_on_floor
var is_attacking = false
var is_dead = false
export var health = 1


func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reload_scene"):
		get_tree().reload_current_scene()


func jump():
	velocity.y = jump_power

#The good stuff		
func _physics_process(delta):
	if is_on_floor():
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite.flip_h = false
			if is_on_floor():
				$AnimatedSprite.play("Walk")
				velocity.x = speed
			else:
				velocity.x = speed
		elif Input.is_action_pressed("ui_left"):
			$AnimatedSprite.flip_h = true
			if is_on_floor():
				$AnimatedSprite.play("Walk")
				velocity.x = -1*speed
			else:
				velocity.x = -1*speed
		else:
			$AnimatedSprite.play("Idle")
			velocity.x = 0
		if Input.is_action_just_pressed("jump"):
			$AnimatedSprite.play("Jump")
			velocity.y = jump_power
	else:
		if sign(velocity.y) == 1:
			$AnimatedSprite.play("Jump")

	
	velocity.y += gravity
	velocity = move_and_slide(velocity,FLOOR)

