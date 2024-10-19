extends Outline

var tween: Tween
var windowOpened: bool = false

	
func interact() -> void:
	tween = get_tree().create_tween()
	if !windowOpened:
		tween.tween_property(mesh, "rotation_degrees", Vector3(-70, 0, 0), 0.5)
	else:
		tween.tween_property(mesh, "rotation_degrees", Vector3(0, 0, 0), 0.5)
		
	windowOpened = !windowOpened
