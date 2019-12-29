extends Control

func _ready() -> void:
	var bootsplash: = "res://src/screens/BootSplash.tscn"
	ScreenManager.emit_signal("transition", bootsplash)
	pass
