extends Control

@onready var lives: HBoxContainer = $MarginContainer/VBoxContainer/Lives

@onready var score_label: Label = $MarginContainer/SCORE  # Renamed to avoid conflict
@onready var back: Button = $MarginContainer/VBoxContainer/Back

var home_screen = "res://scenes/home_page.tscn"

var _hearts: Array

func _ready() -> void:
	_hearts = lives.get_children()

func on_score_updated(new_score: int) -> void:  # Renamed parameter
	score_label.text = "%04d" % new_score  # Use the renamed variable

func _ui_heart_reduction(_lives: int):
	for i in range(_hearts.size()):
		if _lives > i:
			_hearts[i].visible = true
		else:
			# Start blinking effect
			blink_heart(_hearts[i])
			# Hide the heart after blinking
			await get_tree().create_timer(1).timeout
			_hearts[i].visible = false

func blink_heart(heart: Control):
	var blink_duration: float = 0.1
	var blink_count: int = 2
	for i in range(blink_count):
		# Set the heart to invisible
		heart.modulate.a = 0.0
		await get_tree().create_timer(blink_duration / blink_count).timeout
		# Set the heart to visible
		heart.modulate.a = 1.0
		await get_tree().create_timer(blink_duration / blink_count).timeout


func _on_game_score_change(new_score: int) -> void:
	on_score_updated(new_score)
	


func _on_game_lives_reduced(new_lives: int) -> void:
	_ui_heart_reduction(new_lives)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(home_screen)
