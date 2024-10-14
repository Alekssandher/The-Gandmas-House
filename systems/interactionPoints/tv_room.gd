extends Node3D

@export var screamingAudio: AudioStreamPlayer3D
var forniture: Array[MeshInstance3D]
var fornitureTween: Tween
var targetPosition: Vector3
func _ready() -> void:
	
	for item in get_tree().get_nodes_in_group("tvRoomForniture"):
		forniture.append(item)
		
	EventsResources.connect("allTvsOff", allTvsOff)

func allTvsOff() -> void:
	if !EventsResources.interactions["roomsIndex"] == 2: return
	fornitureTween = get_tree().create_tween()
	
	print("worked")
	screamingAudio.play()
	
	for item in forniture:
		targetPosition = item.global_position + Vector3(0, 1.5, 0)
		fornitureTween.tween_property(item, "global_position", targetPosition, 0.7)
	
	
func _on_room_tv_body_entered(body: Node3D) -> void:
	if !body.is_in_group("player"): return
	EventsResources.interactions["roomsIndex"] = 2
	
