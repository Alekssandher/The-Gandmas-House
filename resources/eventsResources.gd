extends Node

var tvsStates: Dictionary = {
	"tvsOn": 0
}

func addState(operation: String, number: int) -> void:
	match operation:
		"more": tvsStates["tvsOn"] += number
		"less": tvsStates["tvsOn"] -= number

func lookingEachOther(
	playerDirection: Vector3, 
	directionToObject: Vector3, 
	dotProduct: float, 
	player: CharacterBody3D, 
	object: CharacterBody3D
	) -> bool:
		
	playerDirection = -player.global_transform.basis.z.normalized()
	directionToObject = (object.global_position - player.global_position).normalized()
	dotProduct = playerDirection.dot(directionToObject)
	return dotProduct > 0.9
