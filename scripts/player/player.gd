extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@export var SPEED = 250.0
@export var JUMP_VELOCITY = -300.0
@export var attacking = false 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		sprite_2d.scale.x = abs(sprite_2d.scale.x) * -1
		$hitbox.scale.x = abs($hitbox.scale.x) * -1
	if Input.is_action_pressed("right"):
		sprite_2d.scale.x = abs(sprite_2d.scale.x)
		$hitbox.scale.x = abs($hitbox.scale.x)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	update_animation()
	move_and_slide()

func attack():
	var overlaping_objects = $hitbox.get_overlapping_areas()
	for area in overlaping_objects:
		var parent = area.get_parent()
		parent.take_damage()
	attacking = true
	animation_player.play("attack1")

func update_animation():
	if !attacking:
		if velocity.x != 0:
			animation_player.play("run")
		else:
			animation_player.play("idle")
		
		if velocity.y < 0:
			animation_player.play("jump")
		if velocity.y > 0:
			animation_player.play("fall")
