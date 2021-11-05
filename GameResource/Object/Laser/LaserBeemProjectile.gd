extends RayCast2D
# Laser Beem Projectile


var damage: float

var can_give_damage := true


func _ready() -> void:
    disable(false)
    AudioManager.play_bullet_shooting_sfx()
    ScreenEffect.start_screen_shake(2.5, .15)
    ScreenEffect.start_abration(15, .3)
    ScreenEffect.start_flash_screen(.03, Color.white)


func _physics_process(_delta: float) -> void:
#    force_raycast_update()
    
    if can_give_damage:
        # give damage to detected body
        if is_instance_valid(get_collider()):
            if get_collider().has_method("take_damage"):
                get_collider().take_damage(damage, global_position)
            can_give_damage = false


func disable(value: bool) -> void:
    set_process(!value)
    set_process_internal(!value)
    set_physics_process(!value)
    set_physics_process_internal(!value)


# will called by player or any object that want it to be projectile
func shoot(_dir, data):
    damage = data.damage
    $AnimationPlayer.play("apear")
