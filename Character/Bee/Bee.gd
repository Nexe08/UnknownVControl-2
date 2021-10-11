extends KinematicBody2D
# Bee

var Life = 1
var velocity:= Vector2.ZERO
onready var can_attack:= false

onready var target

onready var fsm = $AnimationTree.get("parameters/playback")

var bullet = preload("res://Object/Bullet/HostileBullet.tscn")
var dead_animation = preload("res://Object/Effect/Explostion_1.tscn")


func _ready() -> void:
    # update data that enemy is in screen
    EntityData.change_onscreen_bee_count(1)
    EntityData.change_onscreen_enemy_count(1)
    
    Life = EntityData.Bee.Life
    $HealthBar.max_value = Life
    $HealthBar.value = Life
    
    # gets visible while spawning
    $Sprite.visible = false
    $HealthBar.visible = false


func _physics_process(_delta: float) -> void:
    if is_instance_valid(target): # is target (Player) is in tree
        var target_direction = global_position.direction_to(target.global_position)
        var distance_from_target = global_position.distance_to(target.global_position)
        
        $Sprite.flip_h = true if target_direction.x < 0 else false # rotate sprite
        
        if distance_from_target < 64: # move away from target
            _handel_movement(-target_direction, 0.05)
            can_attack = false
        elif distance_from_target > 64 + 32: # move towords target
            _handel_movement(target_direction, 0.05)
            can_attack = false
        else: # stop and fire prokectile on taeget
            velocity = lerp(velocity, Vector2.ZERO, 0.005)
            can_attack = true
    
    velocity = move_and_slide(velocity)


func detect_target():
    if target == null:
        target = Global.Player


func shoot_projectile(): # called in animation player
    var bullet_instance = bullet.instance()
    var target_direction = global_position.direction_to(target.global_position)
    bullet_instance.global_position = global_position
    bullet_instance.shoot(target_direction)
    Global.Game.add_child(bullet_instance)


# accelerate towords direction
func _handel_movement(_direction, _acceleration):
    velocity.x = lerp(velocity.x, 30 * _direction.x, _acceleration)
    velocity.y = lerp(velocity.y, 30 * _direction.y, _acceleration)


func take_damage(_takken_damage, _entity_position = Vector2.ZERO):
    Life -= _takken_damage
    $HealthBar.emit_signal("value_changed", Life)
    
    if Life <= 0:
        self_destruction()
    else:
        fsm.travel("taking_damage")


func self_destruction():
    # effects
    Global.Camera.shake(3, .28)
    ScreenEffect.start_freez_screen(.07)
    ScreenEffect.start_abration(4, .2)
    ScreenEffect.start_flash_screen(.05)
    
    EntityData.change_onscreen_bee_count(-1) # update count
    EntityData.change_onscreen_enemy_count(-1) # update count
    EntityData.change_current_kill_count(1)
    
    var dead_animation_instance = dead_animation.instance()
    dead_animation_instance.global_position = global_position
    Global.Game.add_child(dead_animation_instance)
    queue_free()


func _on_Timer_timeout() -> void:
    if can_attack:
        fsm.travel("attacking")
