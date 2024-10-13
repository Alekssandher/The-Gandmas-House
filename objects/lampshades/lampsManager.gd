extends Node3D

var children: Array[MeshInstance3D]

@export var lightsMesh: MeshInstance3D

func _ready() -> void:
	EventsResources.connect("allTvsOff", allTvsOff)
	
	for child in lightsMesh.get_children():
		#Check if the child has children and add it to the array
		if !child.get_child_count() == 0 && child is MeshInstance3D:
			children.append(child)
	
	
func _process(delta: float) -> void:
	#Check the children of the array
	for child in children:
		#Check the granchildren of each child of the array
		for granchild in child.get_children():
			#Set the visibility of the light to false
			if granchild is OmniLight3D:
				if randi_range(1, 10) == 1: 
					granchild.visible = true
				else: 
					granchild.visible = false
			
func allTvsOff() -> void:
	
	#Check the children of the array
	for child in children:
		#Check the granchildren of each child of the array
		for granchild in child.get_children():
			#Set the visibility of the light to false
			if granchild is OmniLight3D:
				granchild.visible = false
		
		
			

	
	
