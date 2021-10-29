extends Node2D
# Melee Weapon


onready var view_direction:= Vector2.ZERO setget set_view_direction
onready var can_shoot = true

onready var fire_rate_timer = Timer.new()

onready var muzzel = $Muzzel/MuzzelPosition


func _ready() -> void:
    add_child(fire_rate_timer)
    fire_rate_timer.wait_time = 0.4
    fire_rate_timer.connect("timeout", self, "_on_fire_rate_timeout")


func _physics_process(_delta: float) -> void:
    # shooting direction
    if view_direction.x != 0:
#		$Muzzel.scale.x = view_direction.x
        if view_direction.x < 0: # left
            rotation_degrees = 180
            $MeleeSprite.flip_v = true
        else: # right
            rotation_degrees = 0
            $MeleeSprite.flip_v = false
        shoot()
    
    elif view_direction.y != 0: # up and down
        rotation_degrees = 90 * view_direction.y
        shoot()
    
    # reset
    else:
        rotation_degrees = 0
        $MeleeSprite.flip_v = false
        $AnimationPlayer.play("default")


func shoot():
    if can_shoot:
        can_shoot = false
        fire_rate_timer.start()
        var bullet_instance = Global.melee_projectile_path.instance()
        bullet_instance.global_position = muzzel.global_position
        bullet_instance.rotation_degrees = rotation_degrees
        bullet_instance.shoot(view_direction)
        $AnimationPlayer.play("attack")
        Global.Main.add_child(bullet_instance)


func set_view_direction(value: Vector2):
    view_direction = value


func _on_fire_rate_timeout():
    can_shoot = true

