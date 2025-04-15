extends CharacterBody2D

@export var thrust_increase: float = 1.0
@export var max_thrust: float = 5.0
@export var rotation_speed: float = 10.0

var current_thrust: float = 0.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("accelerate"):
		current_thrust += thrust_increase * delta if current_thrust < max_thrust else 0.0
	
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta
		
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta
		
	var velocity = transform.y * current_thrust * -1
	move_and_collide(velocity)
	
