extends AnimatableBody2D

@export var speed: float = 10.0
@export var border_margin: float = 32.0

func _process(delta: float) -> void:
	var velocity = transform.y * speed * delta * -1
	var collision = move_and_collide(velocity)
	
	if collision:
		speed*=-1
	
	var viewport_size = get_viewport().size
	if position.x < (0 - border_margin):
		position.x = viewport_size.x + border_margin
	
	if position.x > (viewport_size.x + border_margin):
		position.x = (0 - border_margin)
		
	if position.y < (0 - border_margin):
		position.y = (viewport_size.y + border_margin)
		
	if position.y > (viewport_size.y + border_margin):
		position.y = (0 - border_margin)
