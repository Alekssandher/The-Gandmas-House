extends MeshInstance3D

@export var lights: Node3D

signal goCar

func _ready() -> void:
	EventsResources.connect("allTvsOff", allTvsOff)


func allTvsOff() -> void:
	
	match EventsResources.interactions["roomsIndex"]:
		0: return
		1: return
		2: createTimer(10, 2);
		3: return

func createTimer(time: float, eventIndex: int) -> void:
	await get_tree().create_timer(time).timeout
	await emit_signal("goCar", eventIndex)

func kys() -> void:
	queue_free()
