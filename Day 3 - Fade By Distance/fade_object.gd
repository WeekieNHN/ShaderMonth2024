class_name FadeObject extends MeshInstance3D

@export var character: Node3D

signal vision_value_changed(value: float)

var material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the first material
	material = mesh.surface_get_material(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	material.set_shader_parameter("CharacterPosition", character.global_position)

func set_vision_value(value: float) -> void:
	material.set_shader_parameter("FadeDistance", clamp(value, 1.0, 20.0))
	
	vision_value_changed.emit(clamp(value, 1.0, 20.0))
