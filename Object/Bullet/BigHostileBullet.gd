extends Area2D
# Big Hostile Bullet

var speed:float
var damage:float
var velocity:= Vector2.ZERO
var LifeTime:float

var created_by = null # Spawned By node @ Sapwner


func _ready() -> void:
    $LifeTime.wait_time = EntityData.BigHostileBullet.LifeTime
    $LifeTime.start()
    damage = EntityData.BigHostileBullet.Damage


func _process(delta: float) -> void:
    velocity = lerp(velocity, Vector2.ZERO, EntityData.BigHostileBullet.Damping * delta)
    move_area(velocity)


func move_area(linear_velocity = Vector2.ZERO):
    global_position += linear_velocity * get_physics_process_delta_time()


func shoot(direction: Vector2, _creation_parent = get_parent()):
    speed = EntityData.BigHostileBullet.Speed
    created_by = _creation_parent
    var impulse = Vector2(speed * direction.x, speed * direction.y)
    velocity = impulse


func self_destruction():
    queue_free()


func _on_LifeTime_timeout() -> void:
    $Tween.stop($Sprite)
    $Tween.start()
    $Tween.repeat = false
    $Tween.interpolate_property($Sprite, "modulate", $Sprite.modulate,
        Color8(255, 255, 255, 0), 0.18, Tween.TRANS_SINE, Tween.EASE_IN)


func _on_TargetDetector_detecting_area(area: Area2D) -> void:
    if created_by != null:
        if created_by.has_mathode("heal"):
            created_by.heal()
    
    self_destruction()
    if area.has_method("take_damage"):
        area.take_damage(damage, self.global_position)


func _on_TargetDetector_detecting_body(body: Node) -> void:
    if is_instance_valid(created_by):
        if created_by.has_method("heal"):
            created_by.heal()
    
    self_destruction()
    if body.has_method("take_damage"):
        body.take_damage(damage, self.global_position)


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
    if object == $Sprite:
        if key == ":modulate":
            queue_free()
