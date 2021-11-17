extends Area2D
# Laser Beem Projectile


var damage: float

var can_give_damage := true


func _ready() -> void:
    disable(false)
    AudioManager.play_bullet_shooting_sfx()
    ScreenEffect.start_screen_shake(2.5, .15)
    ScreenEffect.start_abration(15, .3)
    ScreenEffect.start_flash_screen(.03, Color.white)


func disable(value: bool) -> void:
    set_process(!value)
    set_process_internal(!value)
    set_physics_process(!value)
    set_physics_process_internal(!value)


# will called by player or any object that will fire it as projectile
func shoot(_dir, data):
    damage = data.damage
    $AnimationPlayer.play("apear")


func _on_LaserBeemProjectile_body_entered(body: Node) -> void:
    if body.has_method("take_damage"):
        body.take_damage(damage)
