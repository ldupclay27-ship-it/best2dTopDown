extends StaticBody2D

@export var button_presses_needed: int = 1
# Called when the node enters the scene tree for the first time.
var buttons_pressed: int = 0

func _on_puzzle_button_pressed() -> void:
	buttons_pressed += 1
	if buttons_pressed >= button_presses_needed:
		
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_puzzle_button_unpressed() -> void:
	buttons_pressed -= 1
	if buttons_pressed < button_presses_needed:
		visible = true
		$CollisionShape2D.set_deferred("disabled", false)
	
