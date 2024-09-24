extends Node

class_name Interactable

@export var counterMaterial: StandardMaterial3D
@export var mesh: MeshInstance3D


func _ready() -> void:
	pass
		

func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("playerAim"):
		mesh.material_override.next_pass = counterMaterial
		await World.typingEffect("That's my grandma's car.", 0.1, 1.5)
		await World.typingEffect("It brings me so many memories.", 0.1, 1.5)
		await World.typingEffect("She drove like a F1 pilot, my grandma was crazy.", 0.1, 1.5)
		await World.typingEffect("She loved this car more than anything else in this world.", 0.1, 1.5)
		await World.typingEffect("But now It's here, falling apart.", 0.1, 1.5)


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("playerAim"):
		mesh.material_override.next_pass = null
