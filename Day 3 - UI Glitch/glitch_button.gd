extends Button

@export var glitch_panel: Panel

var glitch_material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Grab our material
	glitch_material = glitch_panel.material
	
	# Connect our function
	pressed.connect(on_pressed)
	
	# Mute the glitch effect
	glitch_material.set_shader_parameter("shake_power", 0.0)
	glitch_material.set_shader_parameter("shake_rate", 0.0)


func on_pressed() -> void:
	print("Glitch time")
	glitch_material.set_shader_parameter("shake_power", 0.03)
	glitch_material.set_shader_parameter("shake_rate", 0.2)
