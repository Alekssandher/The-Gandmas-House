extends Node3D

@export var checkButton: CheckButton
@export var optionButton: OptionButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("leftClick"):
		checkButton.toggle_mode = !checkButton.toggle_mode
		checkButton.set_pressed_no_signal(checkButton.toggle_mode)
	if Input.is_action_just_pressed("left"):
		optionButton.show_popup()


	
	

	
	
