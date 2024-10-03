extends Node

@export_category("Arrays")
@export var lampshadesMesh: Array[MeshInstance3D]

@export var counterMaterial: Material
@export var player: CharacterBody3D

var playerDirection: Vector3
var index: int = 0

func _process(delta: float) -> void:
	pass

func applyOutline() -> void:
	
	while index < lampshadesMesh.size():
		lampshadesMesh[index].material_overlay = counterMaterial
		index += 1
		

func lookingArray() -> void:
	#Calcs if the player and object are in front of each other
	playerDirection = -player.global_transform.basis.z.normalized()
	directionToObject = (lampshadesMesh[0].global_position - player.global_position).normalized()
	dotProductY = playerDirection.dot(directionToObject)
	
	#Returns the result of the calcs with a error margin
	return dotProductY > lookingLimitY
