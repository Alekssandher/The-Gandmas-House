extends Outline

@export var light: OmniLight3D

var check: bool = false
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta: float) -> void:
	looking()
	applyOutline()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("leftClick") and distanceToPlayer < interactDistance:
		light.visible = !check
		check = !check
		
