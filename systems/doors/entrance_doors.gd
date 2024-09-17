extends Node3D

@export var animationPlayer: AnimationPlayer
@export var worldEnviroment: WorldEnvironment

var doorOpened = false
var interactableAreaIn = false
var playerInsideHouse = false

func _process(delta: float) -> void:
	if !interactableAreaIn: return
	print("Opa")
	if Input.is_action_just_pressed("leftClick") and !animationPlayer.is_playing():
		if !doorOpened:
			animationPlayer.play("open")
			doorOpened = true
		
		else:
			animationPlayer.play("close")
			doorOpened = false
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	interactableAreaIn = true

func _on_area_3d_area_exited(area: Area3D) -> void:
	interactableAreaIn = false

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	playerInsideHouse = true


func _on_area_3d_2_body_exited(body: Node3D) -> void:
	playerInsideHouse = false
