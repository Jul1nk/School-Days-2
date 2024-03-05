extends CharacterBody2D

const SPEED = 150.0

var mouse_pos = Vector2.ZERO
var direction = Vector2.RIGHT

@onready var mouse_sprite = $mouse_sprite
@onready var rotatage = $rotatage







func _physics_process(_delta):
	mouse_pos = get_local_mouse_position()
	mouse_sprite.position = mouse_pos
	
	rotatage.rotation = atan2(mouse_pos.y, mouse_pos.x)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var mvt_direction = Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down"))
	if mvt_direction:
		velocity = mvt_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
