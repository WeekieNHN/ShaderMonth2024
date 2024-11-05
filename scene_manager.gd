extends Node

var scenes_to_load: Dictionary = {}
var loaded_scene: PackedScene
var _scene_path: String
var use_sub_threads: bool = true
var _progress: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scenes_to_load[0]			= "res://base_scene.tscn"
	scenes_to_load[1]			= "res://Day 1 - Dissolve/dissolve.tscn"
	scenes_to_load[2]			= "res://Day 2 - UI Blur/ui_blur.tscn"
	scenes_to_load[3]			= "res://Day 3 - Fade By Distance/fade_by_distance.tscn"
	scenes_to_load[4]			= "res://Day 4 - Chromatic Aberration/chromatic abberation.tscn"
	scenes_to_load[5]			= "res://Day 5 - Censor/censor.tscn"
	
func contains(index: int) -> bool:
	return scenes_to_load.has(index)

func load_scene(index: int) -> void:
	# Save the scene path
	_scene_path = scenes_to_load[index]
	print("load: ", _scene_path)
	# Load the scene
	var state = ResourceLoader.load_threaded_request(_scene_path, "", use_sub_threads)
	# Start the process function (_process)
	if state == OK:
		set_process(true)

func _process(_delta: float) -> void:
	# Get the status of our resource being loaded
	var load_status = ResourceLoader.load_threaded_get_status(_scene_path, _progress)
	
	match load_status:
		0, 2: #? THREAD_LOAD_INVALID_RESOURCE, THREAD_LOAD_FAILED
			# Stop loading
			set_process(false)
			return
		3: #? THREAD_LOAD_LOADED
			# Save the loaded resource
			loaded_scene = ResourceLoader.load_threaded_get(_scene_path)
			
			get_tree().change_scene_to_packed(loaded_scene)
