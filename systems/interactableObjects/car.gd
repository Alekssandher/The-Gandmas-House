extends Interactable

class_name Outline


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("playerAim"):
		mesh.material_overlay = counterMaterial
		
		


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("playerAim"):
		mesh.material_overlay = null
