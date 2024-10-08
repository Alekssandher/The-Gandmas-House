extends Outline

@export var video: VideoStreamPlayer
@export var video2: VideoStreamPlayer

@export var audio: AudioStreamPlayer3D
@export var animationPlayer: AnimationPlayer

var canPlay: bool = true

var canTurnOff: bool = true
var audioPosition: float

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.connect("raycastout", raycastout)
	video.play()
	
	
func interact() -> void:
	
	if animationPlayer.is_playing(): return
	
	match canTurnOff:
		true: 
			video2.stream.file = "res://videos/turnOff.ogv"
			animationPlayer.play("turnOff")
			EventsResources.addState("less", 1)
		false: 
			video2.stream.file = "res://videos/turnOn.ogv"
			animationPlayer.play("turnOn")
			EventsResources.addState("more", 1)
			
		
		
func pauseTv() -> void:
	if audio.playing:
		print("stop")
		audioPosition = audio.get_playback_position()
		audio.stop() 
		EventsResources.addState("less", 1)
	else:
		print("play")
		audio.play()
		audio.seek(audioPosition)  
		EventsResources.addState("more", 1)
		
	video.paused = !video.paused
	
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	canTurnOff = !canTurnOff
	
