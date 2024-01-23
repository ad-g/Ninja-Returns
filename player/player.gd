extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	handle_manual_restart()
	handle_manual_quit()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func handle_manual_restart():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func handle_manual_quit():
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
