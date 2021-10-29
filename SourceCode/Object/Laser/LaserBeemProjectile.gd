extends RayCast2D
# Laser Beem Projectile


var damage: float

var is_colliding := true

var hit_partical = preload("res://Object/Effect/BulletExplosition.tscn")


func _ready() -> void:
    AudioManager.play_bullet_shooting_sfx()
    ScreenEffect.start_screen_shake(1, .2)
    ScreenEffect.start_abration(15, .3)


func _physics_process(delta: float) -> void:
    var cast_point := cast_to
#    force_raycast_update()
    
    if is_colliding():
        cast_point = to_local(get_collision_point())
        
        # create hit partical
        if is_colliding:
            $hit_partical_position.position = cast_point
            _add_hit_partical()
            is_colliding = false
        
        if get_collider().has_method("take_damage"):
            get_collider().take_damage(2.0)
    
    $Texture.rect_size = lerp($Texture.rect_size, cast_point, 20*delta)


# will called by player or any object that want it to be projectile
func shoot(_dir, data):
    damage = data.damage
    $AnimationPlayer.play("apear")


func _add_hit_partical():
    var instance = hit_partical.instance()
    instance.position = $hit_partical_position.global_position
    get_parent().add_child(instance)
