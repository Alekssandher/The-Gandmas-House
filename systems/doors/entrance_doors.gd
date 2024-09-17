extends Node3D

@export var animationPlayer: AnimationPlayer
var doorOpened = false
var areaIn = false

func _process(delta: float) -> void:
	if !areaIn: return
	print("Opa")
	if Input.is_action_just_pressed("leftClick") and !animationPlayer.is_playing():
		if !doorOpened:
			animationPlayer.play("open")
			doorOpened = true
		
		else:
			animationPlayer.play("close")
			doorOpened = false
			
func _on_area_3d_area_entered(area: Area3D) -> void:
	areaIn = true

func _on_area_3d_area_exited(area: Area3D) -> void:
	areaIn = false
