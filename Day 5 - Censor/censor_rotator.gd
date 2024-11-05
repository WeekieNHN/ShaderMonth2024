extends Node3D

# Define the range of rotation in degrees
@export var min_rotation: float = -30.0
@export var max_rotation: float = 30.0

# Define the axis of rotation (Vector3.RIGHT for x-axis, Vector3.UP for y-axis, etc.)
@export var rotation_axis: Vector3 = Vector3.UP

# Rotation speed
@export var rotation_speed: float = 1.0

# Internal variable to keep track of target rotation angle
var target_rotation: float = 0.0

func _ready():
	# Set an initial random rotation target
	set_new_target_rotation()

func _process(delta):
	# Smoothly interpolate the rotation toward the target angle
	var current_rotation = rotation_axis.dot(rotation_degrees)
	var new_rotation = lerp(current_rotation, target_rotation, rotation_speed * delta)
	
	# Apply the rotation on the specified axis
	rotation_degrees = rotation_axis * new_rotation
	
	# Check if close to the target rotation and set a new target
	if abs(new_rotation - target_rotation) < 0.1:
		set_new_target_rotation()

func set_new_target_rotation():
	# Set a new random target rotation within the specified range
	target_rotation = randf_range(min_rotation, max_rotation)
