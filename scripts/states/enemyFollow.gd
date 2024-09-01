extends State
class_name EnemyFollow
@export var enemy : CharacterBody2D
@export var move_speed := 200.0
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("player")

func physics_update(delta: float):
	var diraction = player.global_position - enemy.global_position
	if diraction.length() > 25:
		enemy.velocity = diraction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
	if diraction.length() > 50:
		Transitioned.emit(self, "idle")
