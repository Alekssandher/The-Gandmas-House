extends Node3D

@export var animationPlayer: AnimationPlayer
@onready var worldEnviroment: WorldEnvironment = $/root/world/WorldEnvironment
@onready var type: CanvasLayer = $/root/world/CanvasLayer

@export var audio: AudioStreamPlayer3D
var doorOpened := false
var interactableAreaIn := false
var playerInsideHouse := false

func _process(delta: float) -> void:
	if !interactableAreaIn: return
	
	if Input.is_action_just_pressed("leftClick") and !animationPlayer.is_playing():
		animationPlayer.play("close" if doorOpened else "open")
		doorOpened = !doorOpened
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	interactableAreaIn = true
	print(interactableAreaIn)
	await World.typingEffect("Hello world")
	await World.typingEffect("Yeah, it works")
	
func _on_area_3d_area_exited(area: Area3D) -> void:
	interactableAreaIn = false

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	playerInsideHouse = true


func _on_area_3d_2_body_exited(body: Node3D) -> void:
	playerInsideHouse = false

func fogOff() -> void:
	if playerInsideHouse && !doorOpened:
		worldEnviroment.environment.fog_enabled = false
		worldEnviroment.environment.volumetric_fog_enabled = false
		
func fogOn() -> void:
	worldEnviroment.environment.fog_enabled = true
	worldEnviroment.environment.volumetric_fog_enabled = true
	
