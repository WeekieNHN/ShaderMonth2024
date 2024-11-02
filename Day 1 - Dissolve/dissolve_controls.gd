extends Node

@export_group("Dissolve Item")
@export var dissolve_item: DissolveItem

@export_group("UI Elements")
@export var dissolve_in_button: Button
@export var dissolve_out_button: Button
@export var dissolve_value_slider: Slider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect our functions
	dissolve_in_button.pressed.connect(on_dissolve_in_button_pressed)
	dissolve_out_button.pressed.connect(on_dissolve_out_button_pressed)
	dissolve_value_slider.value_changed.connect(on_dissolve_slider_value_changed)
	
	# Connect signal to update slider when value changes on in/out
	dissolve_item.dissolve_value_changed.connect(change_slider_value)

func on_dissolve_in_button_pressed() -> void:
	dissolve_item.dissolve_in()

func on_dissolve_out_button_pressed() -> void:
	dissolve_item.dissolve_out()

func on_dissolve_slider_value_changed(value: float) -> void:
	dissolve_item.set_dissolve_height(1 - value)

func change_slider_value(value: float) -> void:
	dissolve_value_slider.value = 1 - value
