extends Button

func _ready() -> void:
	pressed.connect(quit)

func quit() -> void:
	get_tree().quit()
