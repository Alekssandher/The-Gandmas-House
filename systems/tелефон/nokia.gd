extends Node3D
@export var animationPlayer: AnimationPlayer

func _ready() -> void:
	self.hide()
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		animationPlayer.play("nokiaMenu")
