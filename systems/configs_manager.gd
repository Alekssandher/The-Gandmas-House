extends Node3D

@export_category("Graphics Settings")
@export var worldEnvironment: WorldEnvironment
@export var directionalLight: DirectionalLight3D

var typingEffect := preload("res://systems/typingEffect.tscn").instantiate()

func _ready() -> void:
	
	add_child(typingEffect)
	


func _on_check_button_2_fog_toggle(fog: bool) -> void:
	match fog:
		true: worldEnvironment.environment.fog_enabled = true
		false: worldEnvironment.environment.fog_enabled = false


func _on_check_button_shadow_toggled(shadowToggled: bool) -> void:
	match shadowToggled:
		true: directionalLight.shadow_enabled = true
		false: directionalLight.shadow_enabled = false


func _on_shadow_configs_shadow_quality_toggled(index: int) -> void:
	match index:
		0: directionalLight.directional_shadow_mode = DirectionalLight3D.SHADOW_ORTHOGONAL
		1: directionalLight.directional_shadow_mode = DirectionalLight3D.SHADOW_PARALLEL_2_SPLITS
		2: directionalLight.directional_shadow_mode = DirectionalLight3D.SHADOW_PARALLEL_4_SPLITS
