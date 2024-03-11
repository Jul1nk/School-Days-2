extends CharacterBody2D


const SPEED = 100.0


var mouse_pos = Vector2.ZERO
var direction = Vector2.RIGHT

var is_paused = false

@onready var mouse_sprite = $mouse_sprite
@onready var rotatage = $rotatage
@onready var sprite = $sprite
@onready var flashlight = $rotatage/Flashlight


func _process(_delta):
	if is_paused:
		return
	
		#Handling action keys
	if Input.is_action_just_pressed("flashlight"):
		flashlight.energy = 1 - flashlight.energy


func _physics_process(_delta):
		#Handling mouse position and character rotation
	mouse_pos = get_local_mouse_position()
	mouse_sprite.position = mouse_pos
	rotatage.rotation = atan2(mouse_pos.y, mouse_pos.x)
	#Rotating canvases for player sprite
	for canvas_layer in sprite.get_children():
		canvas_layer.rotation = rotatage.rotation + PI
		canvas_layer.offset = position
	
	if is_paused:
		return
	
	# Basic 2D movement
	var mvt_direction = Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down"))
	if mvt_direction:
		velocity = mvt_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()



func pause():
	is_paused = true

func depause():
	is_paused = false

func tp_cam_to_pos():
	$Camera2D.position_smoothing_enabled = false
	await get_tree().create_timer(0.01).timeout
	$Camera2D.position_smoothing_enabled = true


