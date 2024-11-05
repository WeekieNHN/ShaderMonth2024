extends Node3D  # Change to your object's actual type (e.g., Sprite, MeshInstance)

@export var play_audio: bool = false

# Adjustable properties
@export var min_visible_time: float = 0.1   # Minimum visible time
@export var max_visible_time: float = 0.75   # Maximum visible time
@export var min_hidden_time: float = 0.5   # Minimum visible time
@export var max_hidden_time: float = 2.0   # Maximum visible time

func _ready():
	# Start the visibility cycle when the node is added to the scene
	start_visibility_cycle()

func start_visibility_cycle():
	# Set the object visible and start the random visible time timer
	visible = true
	# Turn on the censor sound, stop talking
	if play_audio: $CensorAudioStreamPlayer.play()
	$TalkingAudioStreamPlayer.stop()
	# Start timer
	$Timer.start(randf_range(min_visible_time, max_visible_time)) 
	await($Timer.timeout)

	# Hide the object and start the hidden time timer
	visible = false
	# Turn off the censor sound, start talking
	$CensorAudioStreamPlayer.stop()
	if play_audio: $TalkingAudioStreamPlayer.play()
	$Timer.start(randf_range(min_hidden_time, max_hidden_time)) 
	await($Timer.timeout)
	
	# Repeat the cycle
	start_visibility_cycle()

func on_enable_audio_changed(value: bool) -> void:
	# Turn on/off audio
	play_audio = value
	
	# Start/stop the audioplayers
	if !value: 
		$TalkingAudioStreamPlayer.stop()
		$CensorAudioStreamPlayer.stop()
	else:
		if (!visible): $TalkingAudioStreamPlayer.play()
		else: $CensorAudioStreamPlayer.play()
