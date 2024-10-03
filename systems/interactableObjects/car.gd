extends ObjectInteract

class_name Outline

@export var localMesh: MeshInstance3D
@export var counterMaterial: Material
@export var lookingLimitY: float

var playerDirectionY: Vector3
var directionToObjectY: Vector3
var dotProductY: float
var distanceToPlayerY: float

func _process(delta: float) -> void:
	
	looking()
	applyOutline()
		
func lookingY() -> bool:
	
	#Calcs if the player and object are in front of each other
	playerDirectionY = -player.global_transform.basis.z.normalized()
	directionToObjectY = (object.global_position - player.global_position).normalized()
	dotProductY = playerDirection.dot(directionToObject)
	
	#Returns the result of the calcs with a error margin
	return dotProductY > lookingLimitY
func applyOutline() -> void:
	
	if distanceToPlayer < interactDistance and looking():
		localMesh.material_overlay = counterMaterial
	else:
		localMesh.material_overlay = null
