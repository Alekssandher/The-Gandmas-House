extends CharacterBody3D

@export var animationPlayer: AnimationPlayer
@export var player: CharacterBody3D
@export var navigationAgent: NavigationAgent3D
@export var mesh: MeshInstance3D

var canFollow: bool = false
var distanceToPlayer: float
var speed: float = 1.2
var dir: Vector3

var playerDirection: Vector3
var directionToObject: Vector3
var dotProduct: float

func _physics_process(delta: float) -> void:
	navigationAgent.target_position = player.global_position
	distanceToPlayer = mesh.global_position.distance_to(player.global_position)
	
	mesh.look_at(player.global_position)
	
	if looking() and distanceToPlayer < 5:
		followPlayer(delta)
		animationPlayer.speed_scale = 3
		animationPlayer.play("following")
	else:
		animationPlayer.play("idle")
		
func followPlayer(delta: float) -> void:
	dir = to_local(navigationAgent.get_next_path_position()).normalized()
	
	velocity = dir * speed
	move_and_slide()
	
func looking() -> bool:
	playerDirection = -player.global_transform.basis.z.normalized()
	directionToObject = (global_position - player.global_position).normalized()
	dotProduct = playerDirection.dot(directionToObject)
	return dotProduct > 0.8
	
