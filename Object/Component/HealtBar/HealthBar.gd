extends ProgressBar
# HealthBar




func _on_HealthBar_value_changed(_value: float) -> void:
    value = _value
    $VisibleTimer.start()
    modulate = Color8(255, 255, 255, 255)


func _on_VisibleTimer_timeout() -> void:
    modulate = Color8(255, 255, 255, 0)
