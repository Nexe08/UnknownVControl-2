extends KinematicBody2D
# Player


var move_speed = 4.5 * 32
var jump_force = 10 * 32
var gravity:= 700
var respawn_position:= Vector2.ZERO

const UP = Vector2.UP

onready var regain_life:= false
onready var is_grounded: bool setget set_is_grounded
onready var velocity:= Vector2.ZERO

onready var GroundDetector = $GroundDetector


func _ready() -> void:
    Global.Player = self
    $BulletCounter.max_value = PlayerData.current_ammo_count


func _physics_process(delta: float) -> void:
    set_is_grounded(_check_for_ground())
    _get_input(delta)
    _handel_life_regain(delta)
    
    velocity.y += gravity * delta
    velocity = move_and_slide(velocity, UP)


func _handel_life_regain(delta):
    if move_direction() == 0: # not moving regain life
        if regain_life:
            if PlayerData.current_life < PlayerData.MAX_LIFE:
                PlayerData.current_life += PlayerData.current_life_regain_speed * delta
                $HealthBar.emit_signal("value_changed", PlayerData.current_life)
            else:
                return
    else:
        regain_life = false
        $LifeRegainCooldown.stop()
        $LifeRegainCooldown.start()


# handling jump
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("w") and is_grounded:
            velocity.y = -jump_force
        
    if event.is_action_released("w") and velocity.y < 0:
        velocity.y = lerp(velocity.y, 0, 0.35)


# when take damage or firing gun
func apply_knockback(amount, direction):
    velocity += amount * direction


# reset positon tp given vector
# called by main or map script based on condition
func respawn(_respawn_position=Vector2.ZERO):
    respawn_position = _respawn_position
    $RespawnTimer.stop()
    $RespawnTimer.start()


func disable(value):
    set_physics_process(!value)
    set_physics_process_internal(!value)
    set_process(!value)
    set_process_internal(!value)


#  called from object that can take damage
func take_damage(_takken_damage, _entity_position = Vector2.ZERO):
    $HitBox/CollisionShape2D2.call_deferred("set_disabled", true)
    
    PlayerData.current_life -= _takken_damage
    $HealthBar.emit_signal("value_changed", PlayerData.current_life)
    
    regain_life = false
    
    $LifeRegainCooldown.wait_time = PlayerData.current_life_regain_time
    $LifeRegainCooldown.stop()
    $LifeRegainCooldown.start()
    
    ScreenEffect.start_screen_shake(1, .25)
    ScreenEffect.start_flash_screen(.05)
    ScreenEffect.start_abration(1, .2)
    ScreenEffect.start_freez_screen(.1)


# movement
func _get_input(_dt):
    # move
    velocity.x = lerp(velocity.x, move_speed * move_direction(), _get_accel_and_deaccel())


func move_direction():
#    return -int(Input.is_action_pressed(\"a\")) + int(Input.is_action_pressed(\"d\"))
    return int(Input.get_action_strength("d") - Input.get_action_strength("a"))


# acceleration and deacceleration
func _get_accel_and_deaccel():
    return 0.2 if is_grounded else 0.05


func _check_for_ground():
    if velocity.y >= 0:
        for raycast in GroundDetector.get_children():
            if raycast.is_colliding():
                return true
            else:
                return false
    else:
        return false


func set_is_grounded(value):
    is_grounded = value


func _on_Gun_bullet_count_updated(value) -> void:
    $BulletCounter.emit_signal("value_changed", value)


func _on_LifeRegainCooldown_timeout() -> void:
    regain_life = true


func _on_RespawnTimer_timeout() -> void:
    global_position = respawn_position


func _on_InvisibiltyTimer_timeout() -> void:
    $HitBox/CollisionShape2D2.call_deferred("set_disabled", false)
