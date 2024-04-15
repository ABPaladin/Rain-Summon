extends Node2D

@onready var path_follow_2d = $".." # Replace ".." with the actual path to your PathFollow2D node
var speed = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate new progress ratio
	var new_progress = path_follow_2d.progress_ratio + delta * speed
	# Clamp progress ratio between 0 and 1
	new_progress = clamp(new_progress, 0, 1)
	if new_progress >= 1:
		new_progress = 0
	# Set the new progress ratio
	path_follow_2d.progress_ratio = new_progress
	# Debug print for progress ratio
