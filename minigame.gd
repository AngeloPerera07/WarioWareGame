extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer 

var garlic_collected = 0 
var timer_end = false 

func _ready() -> void:
	# Automatically find and connect all garlic nodes in the scene
	for child in get_children():
		if child.has_signal("garlic_collected"):
			child.garlic_collected.connect(_on_garlic_collected)

	await themed_timer.Timer(10.0) 
	timer_end = true 

func _process(delta: float) -> void: 
	# AVOID SCENE CHANGING EVERY FRAME: 
	# We move the "win" condition check out of here and into the collection function.
	
	if timer_end: 
		timer_end = false # Prevent this from running multiple times per frame
		if Global.minigames_done != 0:
			Global.minigames_done -= 1 
		Global.lives -= 1 
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn") 

# Rename this slightly to match standard Godot signal conventions
func _on_garlic_collected() -> void: 
	garlic_collected += 1
	
	# Check for win condition IMMEDIATELY when garlic is picked up, 
	# rather than spamming it in _process
	if garlic_collected == 3: 
		if Global.minigames_done > 3: 
			get_tree().change_scene_to_file("res://Scenes/done_screen.tscn") 
		else:
			get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
