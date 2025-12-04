extends CharacterBody2D
class_name Player

@export var move_speed: float = 100.0
@export var push_strength: float = 140.0
@export var acceleration: float = 10

func _ready() -> void :
	position = SceneManager.player_spawn_position
	$Weapon.visible = false
	%Weapon_area.monitoring = false


func _process(delta: float):
	if Input.is_action_just_pressed("interact "):
		attack()

func _physics_process(delta: float) -> void:
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#velocity = move_vector * move_speed
	velocity = velocity.move_toward(move_vector * move_speed, acceleration)
	
	if velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("walk_left")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("walk_down")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("walk_up")
	else:
		$AnimatedSprite2D.stop()
	
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision: 
		#get colliding node
		var collider_node = collision.get_collider()
		if collider_node.is_in_group("movable"):
			# get direction of collision
			print("move")
			# make it negative
			var collision_normal: Vector2 = collision.get_normal()
			collider_node.apply_central_force(-collision_normal * push_strength)
	
	move_and_slide()
	
func attack():
	# show weapon hide weapon turn collision on and off
	$Weapon.visible = true
	%Weapon_area.monitoring = true
	$Weapon_Timer.start()

func _on_hit_box_body_entered(body: Node2D) -> void:
	SceneManager.player_hp -= 1
	print(SceneManager.player_hp)
	#die function 
	if SceneManager.player_hp <= 0:
		die()
	
	var distance_to_player: Vector2
	distance_to_player = global_position - body.global_position
	var knockback_direction: Vector2 = distance_to_player.normalized()
	var knockback_strength: float = 200
	velocity += knockback_direction * knockback_strength

func die():
	SceneManager.player_hp = 3
	get_tree().call_deferred("reload_current_scene")


func _on_weapon_area_body_entered(body: Node2D) -> void:
	body.hp -= 1
	if body.hp <= 0:
		body.queue_free()
	


func _on_weapon_timer_timeout() -> void:
	$Weapon.visible = false
	%Weapon_area.monitoring = false
