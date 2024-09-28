extends Node3D

@export var animationPlayer: AnimationPlayer
@export var audio: AudioStreamPlayer

@export_category("Meshs")
@export var off: MeshInstance3D
@export var turningOn: MeshInstance3D
@export var on: MeshInstance3D


func _ready() -> void:
	pass
func setMeshVisible(num: int) -> void:
	match num:
		0: on.hide(); turningOn.hide();
		1: turningOn.show(); off.hide(); audio.play()
		2: on.show(); turningOn.hide(); off.hide()
