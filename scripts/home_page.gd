extends Control

@onready var start: Button = $Menu_buttons/Start
@onready var instructions: Button = $Menu_buttons/Instructions
@onready var quit: Button = $Menu_buttons/Quit

@export var next_scene: PackedScene


@onready var instructions_screen: Control = $Instructions


func _ready() -> void:
	instructions_screen.hide()
	


func _on_start_pressed() -> void:
	
	if next_scene == null:
		print_debug("scene not defined")
	
	get_tree().change_scene_to_packed(next_scene)


func _on_instructions_pressed() -> void:
	instructions_screen.visible =true


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_close_pressed() -> void:
	instructions_screen.visible = false
