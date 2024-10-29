extends Control

@export var itens: Dictionary
@export var itemList: ItemList

func addItem(itemName: String, icon: Texture, selectable: bool) -> void:
	itemList.add_item(itemName, icon, selectable)
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("openInv"):
		
		if !get_tree().paused:
			get_tree().paused = true
			self.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
		else:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			self.hide()
	
