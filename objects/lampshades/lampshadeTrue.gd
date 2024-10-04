extends Outline

@export var light: OmniLight3D


func interact() -> void:
	light.visible = !light.visible
	
