extends Control

var visibleChars := 0
var canAdvance := false

func _ready() -> void:
	$Label.hide()
	
func _process(delta: float) -> void:
	if $RichTextLabel.visible_ratio < 1:
		$RichTextLabel.visible_ratio += 0 * delta
		
	if visibleChars != $RichTextLabel.visible_characters:
		visibleChars = $RichTextLabel.visible_characters
		$AudioStreamPlayer.pitch_scale = randf_range(0.8, 1.2)
		$AudioStreamPlayer.play()
		
	
	changeScene()

func changeScene() -> void:
	if !canAdvance: return
	for key in range(0, 512):
		if Input.is_key_pressed(key):
			get_tree().change_scene_to_file("res://world.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	canAdvance = true
	$Label.show()
	$AnimationPlayer2.play("labelAnim")
