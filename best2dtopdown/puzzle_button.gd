extends Area2D

signal pressed
signal unpressed

var bodies_on_button: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_body_entered(body: Node2D) -> void:
	bodies_on_button += 1
	if body.is_in_group("movable") or body is Player:
		if bodies_on_button == 1:
			$AnimatedSprite2D.play("On")
			pressed.emit()


func _on_body_exited(body: Node2D) -> void:
	bodies_on_button -= 1
	if body.is_in_group("movable") or body is Player:
		if bodies_on_button == 0:
			$AnimatedSprite2D.play("Off")
			unpressed.emit()

func _process(delta: float) -> void:
	pass
