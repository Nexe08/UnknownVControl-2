extends Particles2D
# Big Explosition


func _ready() -> void:
    emitting = true


func _process(_delta: float) -> void:
    if not emitting:
        queue_free()
