extends Node2D

# warning-ignore:unused_signal
signal get_hit(value)


func _ready() -> void:
    randomize()


func get_hit(value):
    rotation_degrees = lerp(rotation_degrees, value, .12)
    $Tween.start()
    $Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, 0, 3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
