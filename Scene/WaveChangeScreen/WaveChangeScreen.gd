extends Control
# Wave Change Screen

signal next_button_pressed



func _on_NextWaveButton_pressed() -> void:
    emit_signal("next_button_pressed")
