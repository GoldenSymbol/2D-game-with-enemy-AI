extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 200.0
var player : CharacterBody2D
var move_diraction : Vector2
var wander_time : float

func randomize_wander():
	move_diraction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 2)
	
func Enter():
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else: 
		randomize_wander()

func physics_update(delta : float):
	if enemy:
		enemy.velocity = move_diraction * move_speed
	var diraction = player.global_position - enemy.global_position
	var length = diraction.length()
	if length < 500:
		Transitioned.emit(self, "Follow")
