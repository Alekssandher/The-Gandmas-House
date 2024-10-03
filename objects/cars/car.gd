extends Node

var i: int = 0
var timeStart: float
var timeNow: float
var timeElapsed: float

func _ready() -> void:
	timeStart = Time.get_ticks_msec()
	while i < 100000000:
		i += 1
	timeNow = Time.get_ticks_msec()
	timeElapsed = timeNow - timeStart
	print("Time elapsed: ", timeElapsed, " Number: ", i)
	get_tree().quit()

		
