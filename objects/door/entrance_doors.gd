extends Node3D

@export var animationPlayer: AnimationPlayer
@onready var worldEnviroment: WorldEnvironment = $/root/world/WorldEnvironment

@export var audio: AudioStreamPlayer3D
@export var lockedDoorSound: AudioStreamPlayer3D
@export var counter: Material
@export var mesh: MeshInstance3D

var doorOpened := false
var interactableAreaIn := false
var playerInsideHouse := false
var forceClose := false

func interact() -> void:
	if forceClose:
		lockedDoorSound.play()
		return
		
	if !animationPlayer.is_playing():
		animationPlayer.play("close" if doorOpened else "open")
		doorOpened = !doorOpened

func outline() -> void:
	mesh.material_overlay = counter

func raycastout() -> void:
	mesh.material_overlay = null
	
func fogOff() -> void:
	if forceClose: animationPlayer.play("whispers")
	return
	if playerInsideHouse && !doorOpened:
		worldEnviroment.environment.fog_enabled = false
		worldEnviroment.environment.volumetric_fog_enabled = false
		
func fogOn() -> void:
	worldEnviroment.environment.fog_enabled = true
	worldEnviroment.environment.volumetric_fog_enabled = true


func _on_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		playerInsideHouse = true
		forceClose = true
		
		if doorOpened: 
			animationPlayer.play("close")
			doorOpened = false
			await World.typingEffect("", 0.1, 0.5)
			await World.typingEffect("What was that", 0.1, 1.5)
