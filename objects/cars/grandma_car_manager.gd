extends Node3D

@export var animationPlayer: AnimationPlayer
@export var car: MeshInstance3D

func _ready() -> void:
	car.connect("goCar", goCar)
	
func goCar(eventIndex: int) -> void:
	
	match eventIndex:
		0: pass
		1: pass
		2: 
			print("animated")
			eventTwo()
		3: pass
		

func eventTwo() -> void:
	car.lights.visible = true
	animationPlayer.play("goCar")
	if animationPlayer.is_playing(): print("Car anim playing")