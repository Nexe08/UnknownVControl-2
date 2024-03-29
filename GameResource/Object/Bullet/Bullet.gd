extends RigidBody2D
# Bullet

var speed: float
var damage: float
var spread: float


func _ready() -> void:
    AudioManager.play_bullet_shooting_sfx()
    ScreenEffect.start_screen_shake(.3, .2)
    ScreenEffect.start_abration(.15, .1)


func _self_destruction():
    var explosition_instance = Global.Bullet_explosition.instance()
    get_parent().add_child(explosition_instance)
    explosition_instance.global_position = global_position

    queue_free()


func _on_LifeTime_timeout() -> void:
    _self_destruction()


func _on_Bullet_body_entered(body: Node) -> void:
    _self_destruction()
    if body.has_method("take_damage"):
        body.take_damage(damage, self.global_position)


func _on_Area2D_area_entered(area: Area2D) -> void:
    _self_destruction()
    if area.has_method("take_damage"):
        area.take_damage(damage, self.global_position)


func shoot(direction, weapon):
    speed = weapon.speed
    damage = weapon.damage
    spread = weapon.spred
    
    if direction.x != 0:
#        apply_impulse(Vector2.ZERO, Vector2(speed * direction.x, 0))
        apply_impulse(Vector2.ZERO, Vector2(speed * direction.x, rand_range(-spread, spread)))
    
    elif direction.y != 0:
        apply_impulse(Vector2.ZERO, Vector2(rand_range(-spread, spread), speed * direction.y))
