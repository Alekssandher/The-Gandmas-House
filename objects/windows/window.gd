extends Outline

var tween: Tween
var windowOpened: bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.connect("raycastout", raycastout)	
	
func interact() -> void:
	tween = get_tree().create_tween()
	if !windowOpened:
		tween.tween_property(mesh, "rotation_degrees", Vector3(-70, 0, 0), 0.5)
	else:
		tween.tween_property(mesh, "rotation_degrees", Vector3(0, 0, 0), 0.5)
		
	windowOpened = !windowOpened
