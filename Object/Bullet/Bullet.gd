extends RigidBody2D
# Bullet

export var speed:= 800
export var damage:= 1


func _ready() -> void:
    AudioManager.play_bullet_shooting_sfx()
    Global.Camera.shake(.3, 0.2)
    ScreenEffect.start_abration(.3, .1)


func shoot(direction):
    if direction.x != 0:
#        apply_impulse(Vector2.ZERO, Vector2(speed * direction.x, 0))
        apply_impulse(Vector2.ZERO, Vector2(speed * direction.x, rand_range(-32, 32)))
    
    elif direction.y != 0:
        apply_impulse(Vector2.ZERO, Vector2(rand_range(-64, 64), speed * direction.y))


func self_destruction():
    Global.Camera.shake(2, 0.2)
    var explosition_instance = Global.Bullet_explosition.instance()
    get_parent().add_child(explosition_instance)
    explosition_instance.global_position = global_position
    
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
