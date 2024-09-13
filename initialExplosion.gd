extends Area3D

@export var anim: AnimationPlayer
var canExplode = true
func _on_area_entered(area):
	if area.is_in_group("player") and canExplode == true:
		ExplosionManager.activeShake = true
		ExplosionManager.initialExplosion = true
		
		
		anim.play("explosion")
	canExplode = false
	
	


func _on_animation_player_animation_finished(anim_name):
	
	ExplosionManager.activeShake = false
