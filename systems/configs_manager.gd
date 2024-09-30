extends Node3D

@export_category("Graphics Settings")
@export var worldEnvironment: WorldEnvironment
@export var directionalLight: DirectionalLight3D

func _ready() -> void:
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
