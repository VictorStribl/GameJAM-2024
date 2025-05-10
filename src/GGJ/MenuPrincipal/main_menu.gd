class_name MenuPrincipal
extends Control

@onready var start_button = $Iniciar_Button as Button
@onready var exit_button = $Sair_Button as Button
@onready var start_level = load("res://Mundos/mundo.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)

func on_start_pressed() -> void:
		get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
		get_tree().quit()

func _on_check_button_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
