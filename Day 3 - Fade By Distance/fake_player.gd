extends Node3D

@export var marker_parent: Node3D  # The path to the parent of marker nodes
var markers: Array[Node3D] = []
var current_marker_index = 0
@export var speed = 5.0  # Speed in units per second

func _ready():
	# Load marker nodes from the parent node specified by `marker_parent`
	for child in marker_parent.get_children():
		markers.append(child)

func _process(delta):
	
	if markers.size() == 0: return
	
	var target_position = markers[current_marker_index].global_transform.origin
	
	# Move towards the target position
	global_transform.origin = global_transform.origin.move_toward(target_position, speed * delta)
	
	# Check if we've reached the target
	if global_transform.origin.distance_to(target_position) < 0.1:
		current_marker_index += 1  # Move to the next marker
		if current_marker_index >= markers.size():
			current_marker_index = 0  # Loop back to the start
