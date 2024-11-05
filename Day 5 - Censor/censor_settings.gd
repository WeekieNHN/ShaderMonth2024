extends CanvasLayer

@export var censor_quad: MeshInstance3D
@export var pixel_size_slider: Slider
@export var enable_audio_button: CheckButton

var material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the material
	material = censor_quad.mesh.surface_get_material(0)
	
	# Connect our UI
	pixel_size_slider.value_changed.connect(on_pixel_size_changed)
	enable_audio_button.toggled.connect(censor_quad.on_enable_audio_changed)

func on_pixel_size_changed(value: float) -> void:
	# Set the pixel size
	material.set_shader_parameter("pixel_size", int(value))
