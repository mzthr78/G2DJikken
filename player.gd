extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim_sprite = $AnimatedSprite2D

@onready var debug_text = $"../TextEdit"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	debug_text.text = str(is_on_floor())
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim_sprite.play("run")
		anim_sprite.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim_sprite.play("idle")

	move_and_slide()
