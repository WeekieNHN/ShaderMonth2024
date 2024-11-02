extends CanvasLayer

@export_group("Blur Item")
@export var blur_item: Panel

@export_group("UI Elements")
@export var blur_value_slider: Slider
@export var mix_value_slider: Slider
@export var color_picker: ColorPicker
var material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blur_value_slider.value_changed.connect(on_blur_value_changed)
	mix_value_slider.value_changed.connect(on_mix_value_changed)
	color_picker.color_changed.connect(on_color_changed)
	
	# Save reference to our material
	material = blur_item.material

func on_blur_value_changed(value: float) -> void:
	material.set_shader_parameter("BlurAmount", value * 5.0)

func on_mix_value_changed(value: float) -> void:
	material.set_shader_parameter("MixAmount", value)

func on_color_changed(color: Color) -> void:
	material.set_shader_parameter("MixColor", color)
