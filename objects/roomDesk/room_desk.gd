extends Outline

@export var animationPlayer: AnimationPlayer
@export var drawerAudio: AudioStreamPlayer3D
@export var meshs: Array[MeshInstance3D]
@export var tvRoom: Node3D
var drawerOpened: bool = false

func _ready() -> void:
	
	player = get_tree().get_first_node_in_group("player")
	raycast = player.raycast
	raycast.connect("raycastout", raycastout)
	
	tvRoom.noteAdded.connect(noteAdded)
func interact() -> void:
	if animationPlayer.is_playing(): return
	
	drawerOpened = !drawerOpened
	if drawerOpened:
		animationPlayer.play("open")
		drawerAudio["parameters/switch_to_clip"] = "Drawer Opening"
		drawerAudio.play()
	else:
		animationPlayer.play("close")
		drawerAudio["parameters/switch_to_clip"] = "Drawer Closing"
		drawerAudio.play()
		
func outline() -> void:
	if meshs[1].get_child_count() > 0 and drawerOpened: return

	meshs[0].material_overlay = counter
	meshs[1].material_overlay = counter

func raycastout() -> void:
	meshs[0].material_overlay = null
	meshs[1].material_overlay = null
	 
func noteAdded() -> void:
	raycastout()
