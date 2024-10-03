extends CharacterBody3D

@export var animationPlayer: AnimationPlayer
@export var player: CharacterBody3D
@export var navigationAgent: NavigationAgent3D
@export var mesh: MeshInstance3D

var canFollow: bool = false
var speed: float = 1.2
var dir: Vector3



func _physics_process(delta: float) -> void:
	navigationAgent.target_position = player.global_position
	mesh.look_at(player.global_position)
	
	if canFollow:
		followPlayer(delta)
		animationPlayer.speed_scale = 3
		animationPlayer.play("following")
	else:
		animationPlayer.play("idle")
		
func followPlayer(delta: float) -> void:
	
	dir = to_local(navigationAgent.get_next_path_position()).normalized()
	
	velocity = dir * speed
	move_and_slide()
	
	


func _on_object_interact_looking_at() -> void:
	canFollow = true


func _on_object_interact_not_looking_at() -> void:
	canFollow = false
