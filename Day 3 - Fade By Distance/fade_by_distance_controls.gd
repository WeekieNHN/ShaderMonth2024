extends CanvasLayer

@export var fade_out_item: FadeObject

@export var lose_vision_button: Button
@export var temp_vision_button: Button
@export var vision_slider: Slider

func _ready() -> void:
	# Connect our functions
	lose_vision_button.pressed.connect(lose_vision_button_pressed)
	temp_vision_button.pressed.connect(temp_vision_button_pressed)
	vision_slider.value_changed.connect(on_vision_value_changed)
	
	# Connect our slider value to shader value
	fade_out_item.vision_value_changed.connect(set_slider_value)

var losing_vision: bool = false
var temp_vision: bool = false
var timer: float = 0.0

var lose_vision_time: float = 0.75
var temp_vision_time: float = 3.0

func _process(delta: float) -> void:
	if losing_vision:
		# Check if done
		if timer >= lose_vision_time: 
			losing_vision = false
			return
		# Increment timer
		timer += delta
		# Set Distance
		fade_out_item.set_vision_value((1.0 - (timer / lose_vision_time)) * 20.0 + 3.0)
	elif temp_vision:
		# Check if done
		if timer >= temp_vision_time: 
			temp_vision = false
			return
		# Increment timer
		timer += delta
		# otherwise set the distance
		var ratio = timer / temp_vision_time
		# Fade it in
		if ratio < 0.25:
			# Fade vision in
			fade_out_item.set_vision_value(3.0 + ((ratio / 0.25) * 20))
		elif ratio > 0.75:
			# Fade vision out
			var temp_ratio = abs(1 - ratio)
			fade_out_item.set_vision_value(3.0 + (1.0 - ((0.25 - temp_ratio) / 0.25)) * 20)
			

func lose_vision_button_pressed() -> void:
	# Only run if not already
	if (temp_vision or losing_vision): return
	# Reset timer
	timer = 0.0
	# Tell process to run lose vision
	losing_vision = true

func temp_vision_button_pressed() -> void:
	# Only run if not already
	if (temp_vision or losing_vision): return
	# Reset timer
	timer = 0.0
	# Tell process to run lose vision
	temp_vision = true

func on_vision_value_changed(value: float) -> void:
	fade_out_item.set_vision_value(value)

func set_slider_value(value: float) -> void:
	vision_slider.value = value
