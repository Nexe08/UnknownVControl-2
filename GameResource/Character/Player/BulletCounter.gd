extends TextureProgress
# BulletCounter

onready var hide:= false


func _process(_delta: float) -> void:
    if hide == true:
        modulate = modulate.linear_interpolate(Color(1, 1, 1, 0), 10 * get_physics_process_delta_time())


func _on_value_change(_value: float) -> void:
    hide = false
    value = _value
    $Timer.stop()
    $Timer.start()
    modulate = Color(1, 1, 1, 1)


func _hide() -> void:
    hide = true


func _on_WeaponHandler_current_weapon_data_for_ui_emmited(data) -> void:
    max_value = data[1]
    emit_signal("value_changed", data[0])
