class_name ShaderScene extends Node

@export var scene_index: int = 1

@export var next_button: Button
@export var prev_button: Button
@export var back_button: Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect our buttons
	back_button.pressed.connect(on_back_button)
	next_button.pressed.connect(on_next_button)
	prev_button.pressed.connect(on_prev_button)
	
	# Show/hide prev & next buttons
	prev_button.visible = SceneManager.contains(scene_index - 1) and scene_index - 1 != 0
	next_button.visible = SceneManager.contains(scene_index + 1) and scene_index + 1 != 0

func on_next_button() -> void:
	SceneManager.load_scene(scene_index + 1)

func on_prev_button() -> void:
	SceneManager.load_scene(scene_index - 1)

func on_back_button() -> void:
	# Load back to the main menu
	SceneManager.load_scene(0)
