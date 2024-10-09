extends Node3D

@export_category("Graphics Settings")
@export var worldEnvironment: WorldEnvironment
@export var directionalLight: DirectionalLight3D

var typingEffect := preload("res://systems/typingEffect.tscn").instantiate()

func _ready() -> void:
	
	add_child(typingEffect)
	
	setShadowConfigs()
	
func _process(delta: float) -> void:
	setShadowConfigs()

func setShadowConfigs() -> void:
	match World.shadowQuality:
		0: directionalLight.directional_shadow_mode = DirectionalLight3D.SHADOW_ORTHOGONAL
		1: directionalLight.directional_shadow_mode = DirectionalLight3D.SHADOW_PARALLEL_2_SPLITS
		2: directionalLight.directional_shadow_mode = DirectionalLight3D.SHADOW_PARALLEL_4_SPLITS
	
	if World.shadow: 
		directionalLight.shadow_enabled = true
	else: 
		directionalLight.shadow_enabled = false
	#if World.fog:
		#worldEnvironment.environment.fog_enabled = true
	#else:
		#worldEnvironment.environment.fog_enabled = false


func _on_check_button_2_fog_toggle(fog: bool) -> void:
	if fog:
		worldEnvironment.environment.fog_enabled = true
	else:
		worldEnvironment.environment.fog_enabled = false
