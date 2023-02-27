class_name Player
extends KinematicBody2D

var velocity = Vector2.ZERO
var motion = Vector2.ZERO
var movement_direction = Vector2.ZERO

var is_jumping = false
var is_jump_canceled = false

export var movement_speed = Vector2(2, 3.5)
const MAX_movement_speed = 200

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
const FLOOR_NORMAL = Vector2.UP

onready var animation_player = $AnimationPlayer
onready var body = $KinematicBody2D
onready var sprite = $Sprite


func _ready():
	animation_player.play("Idle")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	

	movement_direction = get_direction()

	velocity = calculate_velocity()
	
	print(movement_direction)	

	
	velocity.y += gravity * delta
	
	motion = velocity
	motion = move_and_slide(motion * MAX_movement_speed, FLOOR_NORMAL)
	if motion.x > 0:
		animation_player.play("Running")
		sprite.flip_h = false
		pass
	elif motion.x < 0:
		animation_player.play("Running")
		sprite.flip_h = true
		pass
	else:
		animation_player.play("Idle")

func get_direction():
	return Vector2(
		 Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1 if is_on_floor() and Input.is_action_just_pressed("jump") else 0
	)

func calculate_velocity():
	var current_velocity = velocity
	current_velocity.x = movement_speed.x * movement_direction.x
	if movement_direction.y != 0:
		current_velocity.y = movement_speed.y * movement_direction.y
	return current_velocity
