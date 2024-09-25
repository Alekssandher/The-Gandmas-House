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
		await World.typingEffect("What would it be doing here?", 0.1, 1.5)
		await World.typingEffect("It disappeared with her when she suddenly vanished.", 0.1, 1.5)
		await World.typingEffect("The front light is on though...", 0.1, 1.5)
		await World.typingEffect("Could she be inside... waiting for me?", 0.1, 1.5)
		


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("playerAim"):
		mesh.material_override.next_pass = null
