class_name Player
extends KinematicBody2D

var velocity = Vector2.ZERO
var motion = Vector2.ZERO
var movement_direction = Vector2.ZERO

var is_jumping = false
var is_jump_canceled = false
var gravity_flipped = false

export var movement_speed = 1.5
export var jump_speed = 3.5

const MAX_movement_speed = 200

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var FLOOR_NORMAL = Vector2.UP

onready var animation_player = $AnimationPlayer
onready var body = $KinematicBody2D
onready var sprite = $Sprite


func _ready():
	animation_player.play("Idle")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	movement_direction = get_direction()

	velocity = calculate_velocity(delta)

	motion = velocity
	motion = move_and_slide(motion * MAX_movement_speed, FLOOR_NORMAL)
	
	print(is_on_floor())
	
	if motion.x > 0:
		sprite.flip_h = false
	if motion.x < 0:
		sprite.flip_h = true
		
	if is_on_floor():
		if motion.x != 0:
			animation_player.play("Running")
		else :
			animation_player.play("Idle")
	
	if motion.y > 0:
		animation_player.play("Falling")
	if motion.y < 0:
		animation_player.play("Jumping")
		
func _input(event):
	if event.is_action_pressed("flip_gravity"):
		flip_gravity()

func flip_gravity():
	gravity_flipped = true
	sprite.flip_v = !sprite.flip_v
	gravity = - gravity
	FLOOR_NORMAL = -FLOOR_NORMAL
	velocity.y = 0

func get_direction():
	var flip = gravity_flipped
	gravity_flipped = false
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			vertical = -(gravity/abs(gravity))
		else:
			vertical = 0
	else:
		vertical = gravity/abs(gravity)
	

	return Vector2(
		 horizontal,
			vertical
	)

func calculate_velocity(delta):
	var current_velocity = velocity
	if Input.is_action_just_pressed("jump"):
		current_velocity.y += jump_speed * movement_direction.y
	current_velocity.x = movement_speed * movement_direction.x
	if movement_direction.y != 0:
		current_velocity.y += gravity * delta
	else :
		current_velocity.y = 0
	return current_velocity
