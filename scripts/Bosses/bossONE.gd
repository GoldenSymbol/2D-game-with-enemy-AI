extends CharacterBody2D

func _physics_process(delta):
	move_and_slide()
	if velocity.length() > 0:
		$AnimationPlayer.play("idle")
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
