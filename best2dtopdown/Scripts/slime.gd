extends CharacterBody2D

@export var speed: float = 20

var target: Node2D


func _physics_process(delta: float) -> void:
	if target:
		chasing()
	else:
		speed = 20
	animate_enemy()
	move_and_slide()

func chasing():
	var distance_to_player: Vector2
	distance_to_player = target.global_position - global_position
	var direction_normal: Vector2 = distance_to_player.normalized()
	if speed > 0.0:
		speed -= 0.01
	velocity = direction_normal * speed

func animate_enemy():
	var normal_velocity: Vector2 = velocity.normalized()
	if normal_velocity.x > 0.7:
		$AnimatedSprite2D.play("moveRight")
	elif normal_velocity.x < -0.7:
		$AnimatedSprite2D.play("moveLeft")
	elif normal_velocity.y > 0.7:
		$AnimatedSprite2D.play("moveDown")
	elif normal_velocity.y < -0.7:
		$AnimatedSprite2D.play("moveUp")
	else: 
		$AnimatedSprite2D.play("idle")

func _on_chasing_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
		speed = 50
