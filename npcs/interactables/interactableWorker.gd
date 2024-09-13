extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@export var label: Label3D
@export var dialogueAnim: AnimationPlayer
@export var legenda: Label

var collided

func _ready():
	legenda.hide()
	
func _process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
	
	if collided == true:  # Verifica se está colidindo
		if Input.is_action_just_pressed("interact"): 
			print("Checking interaction on collision") 
			# Depuração
			label.hide()
			legenda.show()
			dialogueAnim.play("testTalk")
	else:
		collided = false
		label.show()
		
func _on_animation_player_animation_finished(anim_name):
	legenda.hide()
	label.hide()

func _on_area_3d_area_entered(area):
	collided = true
	print("In area")




func _on_area_3d_area_exited(area):
	collided = false
