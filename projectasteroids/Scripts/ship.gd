extends CharacterBody2D

@export var thrust_increase: float = 1.0
@export var max_thrust: float = 5.0
@export var rotation_speed: float = 25.0
@export var friction: float = 0.25
@export var break_force: float = 1.0

var current_thrust: float = 0.0

func _process(delta: float) -> void:
	ProcessInput(delta)
	Move()
	Friction(delta)
	print(current_thrust)
	
func ProcessInput(delta:float) -> void:
	if Input.is_action_pressed("accelerate"):
		current_thrust += thrust_increase * delta if current_thrust < max_thrust else 0.0
	elif Input.is_action_pressed("break"):
		current_thrust = current_thrust - (break_force * delta) if current_thrust >= break_force else 0.0
	
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta
		
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta
		
func Move() -> void:
	velocity = transform.y * current_thrust * -1
	move_and_collide(velocity)
	
func Friction(delta: float) -> void:
	current_thrust -= (friction * delta) if current_thrust >= friction else 0.0
