extends Area2D
# Malee Projectile
var velocity:= Vector2.ZERO
var speed = 600


func _ready() -> void:
    Global.Camera.shake(.3, 0.3)
    scale = Vector2(.1, .1)


func _process(_delta: float) -> void:
    modulate = lerp(modulate, Color8(255, 255, 255, 0), 0.14)
    scale = lerp(scale, Vector2(1, 1), .3)
    velocity = lerp(velocity, Vector2.ZERO, 0.2)
    move_area(velocity)


func shoot(direction = Vector2.ZERO):
    velocity = Vector2(speed, speed) * direction


func move_area(linear_velocity = Vector2.ZERO):
    global_position += linear_velocity * get_physics_process_delta_time()


func _on_LifeTime_timeout() -> void:
    queue_free()
