extends Button

@export var scene_index: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect our button
	pressed.connect(on_press)


func on_press() -> void:
	# Only load if we can
	if (!SceneManager.contains(scene_index)): return
	# Load the scene
	SceneManager.load_scene(scene_index)
