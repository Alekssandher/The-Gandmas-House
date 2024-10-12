extends Node

var TvsOffEmited: bool = false

var tvsStates: Dictionary = {
	"tvsOn": 3
	
}
signal allTvsOff

func _process(dealta: float) -> void:
	if tvsStates["tvsOn"] == 0 && !TvsOffEmited:
		print("0 tvs on")
		emit_signal("allTvsOff")
		TvsOffEmited = true
func addState(operation: String, number: int) -> void:
	match operation:
		"more": tvsStates["tvsOn"] += number
		"less": tvsStates["tvsOn"] -= number
