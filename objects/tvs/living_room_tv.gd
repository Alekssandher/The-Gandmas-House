extends MeshInstance3D

@export var video: VideoStreamPlayer
@export var video2: VideoStreamPlayer

@export var audio: AudioStreamPlayer3D
@export var animationPlayer: AnimationPlayer

var canPlay := true
var count :float = 0.0
var canTurnOff := true
var aimNear := false
var audioPosition: float

func _ready() -> void:
	video.play()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("leftClick") and aimNear and !animationPlayer.is_playing():
		match canTurnOff:
			true: 
				video2.stream.file = "res://systems/firstScene/turnOff.ogg"
				animationPlayer.play("turnOff")
			false: 
				video2.stream.file = "res://systems/firstScene/turnOn.ogg"
				animationPlayer.play("turnOn")
				
	
func _process(delta: float) -> void:
	if TvsEvents.inFirstTvArea:
		count += delta
		
		
func pauseTv() -> void:
	if audio.playing:
		audioPosition = audio.get_playback_position()
		audio.stop() 
	else:
		audio.play()
		audio.seek(audioPosition)  
		
	video.paused = !video.paused
	
	
func _on_timer_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		TvsEvents.inFirstTvArea = true
		if !canPlay: return
		video.stream.file = "res://videos/cartoon.ogg"
		audio.play()
		video.play()


func _on_timer_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		TvsEvents.inFirstTvArea = false
		canPlay = false

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("playerAim"):
		aimNear = true

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("playerAim"):
		aimNear = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	canTurnOff = !canTurnOff
