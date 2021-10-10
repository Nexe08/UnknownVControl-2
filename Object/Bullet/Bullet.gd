extends RigidBody2D
# Bullet

export var speed:= 800
export var damage:= 50


func _ready() -> void:
    Global.Camera.shake(.3, 0.2)
    ScreenEffect.start_abration(.3, .1)


func shoot(direction):
    if direction.x != 0:
        apply_impulse(Vector2.ZERO, Vector2(speed * direction.x, 0))
    
    elif direction.y != 0:
        apply_impulse(Vector2.ZERO, Vector2(0, speed * direction.y))


func self_destruction():
    queue_free()


func _on_LifeTime_timeout() -> void:
    self_destruction()


func _on_Bullet_body_entered(body: Node) -> void:
    self_destruction()
    if body.has_method("take_damage"):
        body.take_damage(damage, self.global_position)


func _on_Area2D_area_entered(area: Area2D) -> void:
    self_destruction()
    if area.has_method("take_damage"):
        area.take_damage(damage, self.global_position)
