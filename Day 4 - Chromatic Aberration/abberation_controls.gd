extends CanvasLayer

@export var width_slider: Slider
@export var height_slider: Slider
@export var fade_slider: Slider

@export var red_slider: Slider
@export var green_slider: Slider
@export var blue_slider: Slider

@export var abberation_panel: Panel

var material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get our material
	material = abberation_panel.material
	
	# Connect vignette sliders
	width_slider.value_changed.connect(width_value_changed)
	height_slider.value_changed.connect(height_value_changed)
	fade_slider.value_changed.connect(fade_value_changed)
	
	# Connect color sliders
	red_slider.value_changed.connect(red_value_changed)
	green_slider.value_changed.connect(green_value_changed)
	blue_slider.value_changed.connect(blue_value_changed)

func width_value_changed(value: float) -> void:
	material.set_shader_parameter("Width", value)

func height_value_changed(value: float) -> void:
	material.set_shader_parameter("Height", value)

func fade_value_changed(value: float) -> void:
	material.set_shader_parameter("Fade", value)

func red_value_changed(value: float) -> void:
	var new_vec: Vector2 = Vector2(1.0, 0.0)
	material.set_shader_parameter("RedDisplacement", new_vec * value)

func green_value_changed(value: float) -> void:
	var new_vec: Vector2 = Vector2(0.0, 1.0)
	material.set_shader_parameter("GreenDisplacement", new_vec * value)

func blue_value_changed(value: float) -> void:
	var new_vec: Vector2 = Vector2(-1.0, 0.0)
	material.set_shader_parameter("BlueDisplacement", new_vec * value)
