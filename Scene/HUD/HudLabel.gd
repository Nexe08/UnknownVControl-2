extends Label
# HUD Label


func _ready() -> void:
    rect_position.x = -rect_size.x
    $Tween2.start()
    $Tween2.interpolate_property(self, "rect_position:x", rect_position.x, 0,
    1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)


func _on_Timer_timeout() -> void:
    $Tween.start()
    $Tween.interpolate_property(self, "rect_position:x", rect_position.x, -rect_size.x,
    1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)


func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
    queue_free()


func _on_Tween2_tween_completed(_object: Object, _key: NodePath) -> void:
    $Timer.start()
