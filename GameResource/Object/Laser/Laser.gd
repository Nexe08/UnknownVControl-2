extends RayCast2D
# Laser

var damage:= 2.0

var is_casting := false setget set_is_casting


func _ready() -> void:
    set_physics_process(false)
    $Line2D.points[1] = Vector2.ZERO


func _physics_process(_delta: float) -> void:
    var cast_point := cast_to
    force_raycast_update()
    
    if is_colliding():
        cast_point = to_local(get_collision_point())
        
        if get_collider().has_method("take_damage"):
            get_collider().take_damage(2.0)
    
    $Line2D.points[1] = cast_point


# setget function
# used to get access from another script
func set_is_casting(cast: bool):
    is_casting = cast
    
    if is_casting:
        apear()
    else:
        disapear()
    
    set_physics_process(is_casting)


func apear():
    $Tween.stop_all()
    $Tween.interpolate_property($Line2D, "width", 0, 10.0, 0.2)
    $Tween.start()


func disapear():
    $Tween.stop_all()
    $Tween.interpolate_property($Line2D, "width", 10.0, 0, 0.2)
    $Tween.start()
