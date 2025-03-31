extends Control

@onready var lives: HBoxContainer = $MarginContainer/Lives
@onready var score_label: Label = $MarginContainer/SCORE  # Renamed to avoid conflict



var _hearts: Array

func _ready() -> void:
	_hearts = lives.get_children()
	var game_instance = get_tree().get_root().get_child(0)
	game_instance.lives_reduced.connect(_on_life_reduced)

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
	var blink_count: int = 1
	for i in range(blink_count):
		# Set the heart to invisible
		heart.modulate.a = 0.0
		await get_tree().create_timer(blink_duration / blink_count).timeout
		# Set the heart to visible
		heart.modulate.a = 1.0
		await get_tree().create_timer(blink_duration / blink_count).timeout


func _on_game_score_change(new_score: int) -> void:
	on_score_updated(new_score)
	
func _on_life_reduced(_lives:int):
	_ui_heart_reduction(_lives)
