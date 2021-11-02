extends Area2D
# Hostile Bullet

var speed:= 140
var damage:= 1
var velocity:= Vector2.ZERO


func _ready() -> void:
    scale = Vector2(0.1, 0.1)
    $Tween.start()
    $Tween.interpolate_property(self, "scale", scale,
        Vector2(1, 1), 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)


func _process(_delta: float) -> void:
    velocity = lerp(velocity, Vector2.ZERO, 0.02)
    move_area(velocity)


func move_area(linear_velocity = Vector2.ZERO):
    global_position += linear_velocity * get_physics_process_delta_time()


func shoot(direction: Vector2):
    var impulse = Vector2(speed * direction.x, speed * direction.y)
    velocity = impulse
#	apply_impulse(Vector2.ZERO, impulse)


func self_destruction():
    queue_free()


func _on_LifeTime_timeout() -> void:
    $Tween.stop($Sprite)
    $Tween.start()
    $Tween.repeat = false
    $Tween.interpolate_property($Sprite, "scale", $Sprite.scale,
        Vector2.ZERO, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)


func _on_TargetDetector_detecting_area(area: Area2D) -> void:
    self_destruction()
    if area.has_method("take_damage"):
        area.take_damage(damage, self.global_position)


func _on_TargetDetector_detecting_body(body: Node) -> void:
    self_destruction()
    if body.has_method("take_damage"):
        body.take_damage(damage, self.global_position)


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
    if object == $Sprite:
        if key == ":scale":
            queue_free()
