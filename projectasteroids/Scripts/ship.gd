extends CharacterBody2D
# This script defines the basic behaviour of a ship, including movement, firing, interaction with
# the level and customization

#---------------------------------------------------------------------------------------------------
# Fields
#---------------------------------------------------------------------------------------------------

@export var thrust_increase: float = 1.0        # Acceleration increse when the action is detected
@export var max_thrust: float = 5.0             # Max acceleration of the ship
@export var rotation_speed: float = 25.0        # Rotation speed of the ship in degrees when the action is detected
@export var friction: float = 0.25              # Deacceleration of the ship when no thrust is applied
@export var break_force: float = 1.0            # Deacceleration of the ship when the break action is detected
@export var border_margin: float = 64.0         # Margin in pixels for the ship to be re-positioned to the other side of the screen when moving out of bounds

var current_thrust: float = 0.0                 # Current forward acceleration of the ship

#---------------------------------------------------------------------------------------------------
# Node2D Functions
#---------------------------------------------------------------------------------------------------

func _process(delta: float) -> void:
	ProcessInput(delta)
	Move()
	Friction(delta)

#---------------------------------------------------------------------------------------------------
# Functions
#---------------------------------------------------------------------------------------------------

# Checks and coordinates the input detection for all actions
func ProcessInput(delta:float) -> void:
	if Input.is_action_pressed("accelerate"):
		current_thrust += thrust_increase * delta if current_thrust < max_thrust else 0.0
	elif Input.is_action_pressed("break"):
		current_thrust = current_thrust - (break_force * delta) if current_thrust >= break_force else 0.0

	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta
		
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta

# Moves the ship based on the current value of the ship's thrust and the local forward
# Also changes the position of the ship when going beyond the borders of the current viewport
func Move() -> void:
	velocity = transform.y * current_thrust * -1
	move_and_collide(velocity)
	
	var viewport_size = get_viewport().size
	if position.x < (0 - border_margin):
		position.x = viewport_size.x + border_margin
	
	if position.x > (viewport_size.x + border_margin):
		position.x = (0 - border_margin)
		
	if position.y < (0 - border_margin):
		position.y = (viewport_size.y + border_margin)
		
	if position.y > (viewport_size.y + border_margin):
		position.y = (0 - border_margin)

# Deaccelerates the ship if no thrust is actively applied by the player
func Friction(delta: float) -> void:
	current_thrust -= (friction * delta) if current_thrust >= friction else 0.0
	
#---------------------------------------------------------------------------------------------------
# Callbacks
#---------------------------------------------------------------------------------------------------
