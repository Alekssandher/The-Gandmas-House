extends Control

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if !get_tree().paused:
			get_tree().paused = true
			self.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
			
		else:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			self.hide()
