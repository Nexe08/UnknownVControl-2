extends Node2D
# Gun

signal bullet_count_updated(value)

onready var view_direction:= Vector2.ZERO setget set_view_direction
onready var can_shoot:= true
onready var refill_mag:= false

onready var fire_rate_timer = Timer.new()

onready var muzzel = $Muzzel/MuzzelPosition


func _ready() -> void:
    set_current_ammo_count(PlayerData.current_ammo_count)
    
    add_child(fire_rate_timer)
    fire_rate_timer.wait_time = PlayerData.current_fire_rate
    fire_rate_timer.connect("timeout", self, "_on_fire_rate_timeout")
    
    $ReloadTime.wait_time = PlayerData.current_reload_time
    
    $Muzzel/FlashAnimation/MuzzelFlash.playback_speed = 2


func _physics_process(delta: float) -> void:
    _handel_shooting_direction(delta)
    _handel_refilling_mag(delta)


func _handel_refilling_mag(delta: float):
    if refill_mag == true:
        if PlayerData.current_ammo_count <= PlayerData.current_mag_capacity:
            PlayerData.current_ammo_count += PlayerData.current_reload_speed * delta
            set_current_ammo_count(PlayerData.current_ammo_count)
        else:
            refill_mag = false


# use angle in radian indted of degrees to fix this mess
func _handel_shooting_direction(_dt):
    # shooting direction
    if view_direction.x != 0:
        if view_direction.x < 0: # left
            muzzel.rotation_degrees = 180
            $Muzzel.rotation_degrees = 180
            $GunSprite.rotation_degrees = 180
            $GunSprite.flip_v = true
        else: # right
            muzzel.rotation_degrees = 0
            $Muzzel.rotation_degrees = 0
            $GunSprite.rotation_degrees = 0
            $GunSprite.flip_v = false
        shoot()
    
    elif view_direction.y != 0: # up and down
        $GunSprite.rotation_degrees = 90 * view_direction.y
        muzzel.rotation_degrees = 90 * view_direction.y
        $Muzzel.rotation_degrees = 90 * view_direction.y
        shoot()
    
    # reset
    else:
        $GunSprite.rotation_degrees = 0
        $Muzzel.rotation_degrees = 0
        $GunSprite.flip_v = false


func shoot():
    refill_mag = false
    
    if PlayerData.current_ammo_count > 0:
        if can_shoot:
            PlayerData.current_ammo_count -= 1
            can_shoot = false
            fire_rate_timer.wait_time = PlayerData.current_fire_rate
            fire_rate_timer.start()
            var bullet_instance = Global.bullet_path.instance()
            bullet_instance.global_position = muzzel.global_position
            bullet_instance.rotation_degrees = muzzel.rotation_degrees
            bullet_instance.shoot(view_direction)
            Global.Player.apply_knockback(20, -view_direction)
            $Muzzel/FlashAnimation/MuzzelFlash.play("Flash")
            Global.Player.get_parent().add_child(bullet_instance)
        
    if PlayerData.current_ammo_count < PlayerData.current_mag_capacity:
        $ReloadTime.wait_time = PlayerData.current_reload_time
        $ReloadTime.stop()
        $ReloadTime.start()
    else:
        refill_mag = false
    
    set_current_ammo_count(PlayerData.current_ammo_count)


func set_current_ammo_count(_value):
    PlayerData.current_ammo_count = _value
    emit_signal("bullet_count_updated", PlayerData.current_ammo_count) # update visual 


func set_view_direction(value: Vector2):
    view_direction = value


func _on_fire_rate_timeout():
    can_shoot = true


func _on_MagRefillCooldown_timeout() -> void:
    refill_mag = true
