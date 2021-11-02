extends ViewportContainer
# Background


func _ready() -> void:
    randomize()


func _process(delta: float) -> void:
    move_cloud(delta)


func move_cloud(delta):
    var velocity = Vector2.ZERO
    var speed = 20
    velocity.x = lerp(velocity.x, speed, 0.8 * delta)
    $Cloud.global_position += velocity
    
    for sprite in $Cloud.get_children():
        if sprite.global_position.x > get_viewport().get_visible_rect().size.x + 50:
            sprite.global_position.x = -50
            sprite.global_position.y = rand_range(0, get_viewport().get_visible_rect().size.y - 50)
