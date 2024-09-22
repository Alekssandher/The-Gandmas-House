extends SpotLight3D


func _input() -> void:
	if Input.is_action_just_pressed("interact"):
		
		if visible: visible = false
		else: visible = true
