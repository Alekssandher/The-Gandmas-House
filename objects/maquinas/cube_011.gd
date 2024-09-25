extends MeshInstance3D

var canAppear := true


func _on_area_3d_area_entered(area: Area3D) -> void:
	if !canAppear: return
	await World.typingEffect("Is that what they call an easter egg?", 0.1, 2)
	await World.typingEffect("Who knows...", 0.1, 2)
	canAppear = false
