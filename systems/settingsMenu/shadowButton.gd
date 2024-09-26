extends CheckButton



func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		World.shadow = true
	else: World.shadow = false
