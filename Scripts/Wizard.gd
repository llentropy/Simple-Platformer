class_name Player
extends KinematicBody2D

var velocity = Vector2.ZERO
var motion = Vector2.ZERO
var movement_direction = Vector2.ZERO

var is_jumping = false
var is_jump_canceled = false
var gravity_flipped = false

onready var collected_scrolls = 0
export var movement_speed = 1.5
export var jump_speed = 3.5

const MAX_movement_speed = 200

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var current_floor_normal = Vector2.UP

onready var animation_player = $AnimationPlayer
onready var body = $KinematicBody2D
onready var sprite = $Sprite

onready var room_entered_position = Vector2.ZERO


func _ready():
	animation_player.play("Idle")
	room_entered_position = self.position

func _physics_process(delta):
	movement_direction = get_direction()

	velocity = calculate_velocity(delta)

	motion = move_and_slide(velocity * MAX_movement_speed, current_floor_normal)
	
	if motion.x > 0:
		sprite.flip_h = false
	if motion.x < 0:
		sprite.flip_h = true
		
	if is_on_floor():
		if motion.x != 0:
			animation_player.play("Running")
		else :
			animation_player.play("Idle")
	
	if motion.y * gravity > 0:
		animation_player.play("Falling")
	if motion.y * gravity < 0:
		animation_player.play("Jumping")
		

func _input(event):
	if event.is_action_pressed("flip_gravity"):
		flip_gravity()


func flip_gravity():
	gravity_flipped = true
	sprite.flip_v = !sprite.flip_v
	gravity = - gravity
	current_floor_normal = -current_floor_normal
	velocity.y = 0

func get_direction():
	var flip = gravity_flipped
	gravity_flipped = false
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			vertical = -sign(gravity)
		else:
			vertical = 0
	else:
		vertical = sign(gravity)
	

	return Vector2(
		 horizontal,
			vertical
	)

func calculate_velocity(delta):
	var current_velocity = velocity
	if Input.is_action_just_pressed("jump") and is_on_floor():
		current_velocity.y += jump_speed * movement_direction.y
	if Input.is_action_just_released("jump") and current_velocity.y /gravity < 0:
		current_velocity.y *= 0.7
		
	current_velocity.x = movement_speed * movement_direction.x
	if movement_direction.y != 0:
		current_velocity.y += gravity * delta
	else :
		current_velocity.y = 0
	return current_velocity

func collect_object(object):
	if "Scroll" in object.name:
		collected_scrolls += 1 
		print(collected_scrolls)

func update_last_entered_position():
	room_entered_position = self.position
