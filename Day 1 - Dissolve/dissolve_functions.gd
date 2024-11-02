class_name DissolveItem extends MeshInstance3D


var material: ShaderMaterial


@export var dissolve_height_radius: float = -0.6

@export var dissolve_duration: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get our only material
	material = mesh.surface_get_material(0)

func set_dissolve_height(value: float) -> void:
	# Clamp the value
	value = clamp(value, 0.0, 1.0)
	# Set the shader param
	material.set_shader_parameter("DissolveHeight", (value * dissolve_height_radius) * 2 - dissolve_height_radius)

func dissolve_out() -> void:
	dissolving = 1
	timer = 0.0

func dissolve_in() -> void:
	dissolving = -1
	timer = 0.0

var dissolving: int = 0
var timer: float = 0.0

signal dissolve_value_changed(value: float)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If not dissolving, return
	if dissolving == 0 or timer > dissolve_duration: return
	
	# Increment the timer
	timer += delta
	
	# Otherwise, we're dissolving, set the shader parameter
	if dissolving == -1: 
		# Set the parameter
		material.set_shader_parameter("DissolveHeight", ((1 - (timer / dissolve_duration)) * dissolve_height_radius) * 2 - dissolve_height_radius)
		# Update the slider using a signal
		dissolve_value_changed.emit(1 - (timer / dissolve_duration))
	else:
		# Set the parameter
		material.set_shader_parameter("DissolveHeight", ((timer / dissolve_duration) * dissolve_height_radius) * 2 - dissolve_height_radius)
		# Update the slider using a signal
		dissolve_value_changed.emit(timer / dissolve_duration)
	
	
