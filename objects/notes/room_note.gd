extends Outline

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	raycast = player.raycast
	raycast.connect("raycastout", raycastout)
	
func interact() -> void:
	
	queue_free()
