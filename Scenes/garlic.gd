extends Node2D

@onready var player: CharacterBody2D = $"../Player"
@onready var self_area = $Area2D
# Using the safe get_node_or_null helper prevents the game from hard crashing
@onready var player_area = $"../Player/Area2D"

signal garlic_collected

func _process(delta: float) -> void:
	# The "if player_area:" check ensures the game won't crash if loading order is slightly off
	if player_area and player_area.overlaps_area(self_area):
		if self.visible:
			emit_signal("garlic_collected")
			self.hide()
