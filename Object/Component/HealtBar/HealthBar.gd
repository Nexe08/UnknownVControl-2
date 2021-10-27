extends ProgressBar
# HealthBar




func _on_HealthBar_value_changed(_value: float) -> void:
    value = _value
    $VisibleTimer.start()
    visible = true
#    modulate = Color8(255, 255, 255, 255)


func _on_VisibleTimer_timeout() -> void:
    visible = false
#    modulate = Color8(255, 255, 255, 0)
