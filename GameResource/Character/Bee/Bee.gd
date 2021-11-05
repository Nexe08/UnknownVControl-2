extends KinematicBody2D
# Bee

export var life: float # = EntityData.Bee.Life
export var passiv_mode:= false

var velocity:= Vector2.ZERO

onready var can_attack:= false
onready var can_take_damage:= false setget set_can_take_damage

onready var target
onready var sibling

onready var fsm = $AnimationTree.get("parameters/playback")

var bullet = preload("res://Object/Bullet/HostileBullet.tscn")
var dead_animation = preload("res://Object/Effect/Explostion_1.tscn")


func _ready() -> void:
    # update data that enemy is in screen
    EntityData.change_onscreen_bee_count(1)
    EntityData.change_onscreen_enemy_count(1)
    
    $HealthBar.max_value = life
    $HealthBar.value = life
    
    # gets visible while spawning
    $Sprite.visible = false
    $HealthBar.visible = false


func _physics_process(_delta: float) -> void:
#    if is_instance_valid(target): # is target (Player) is in tree
#        var target_direction = global_position.direction_to(target.global_position)
#        var distance_from_target = global_position.distance_to(target.global_position)
#
#        $Sprite.flip_h = true if target_direction.x < 0 else false # rotate sprite
#
#        if distance_from_target < 64: # move away from target
#            _handel_movement(-target_direction, 0.05)
#            can_attack = false
#        elif distance_from_target > 64 + 32: # move towords target
#            _handel_movement(target_direction, 0.05)
#            can_attack = false
#        else: # stop and fire projectile on taeget
#            velocity = lerp(velocity, Vector2.ZERO, 0.005)
#            can_attack = true
    
    velocity = move_and_slide(velocity)


# called in animation player
func detect_target():
    if target == null:
        target = Global.Player
    
    if is_instance_valid(target): # is target (Player) is in tree
        var target_direction = global_position.direction_to(target.global_position)
        var distance_from_target = global_position.distance_to(target.global_position)
        
        $Sprite.flip_h = true if target_direction.x < 0 else false # rotate sprite
        
        if distance_from_target < 64: # move away from target
            _handel_movement(-target_direction, EntityData.Bee.Movement_accel)
            can_attack = false
        elif distance_from_target > 64 + 32: # move towords target
            _handel_movement(target_direction, EntityData.Bee.Movement_accel)
            can_attack = false
        else: # stop and fire projectile on taeget
            velocity = lerp(velocity, Vector2.ZERO, EntityData.Bee.Movement_accel)
            can_attack = true


# called in animtion player 
func detect_sibling():
    if sibling == null:
        return
    
    if is_instance_valid(sibling):
        var dir = global_position.direction_to(sibling.global_position)
        _handel_movement(-dir, EntityData.Bee.Movement_accel)


func shoot_projectile(): # called in animation player
    var bullet_instance = Global.HostileBullet.instance()
    var target_direction = global_position.direction_to(target.global_position)
    get_parent().add_child(bullet_instance)
    bullet_instance.global_position = global_position
    bullet_instance.shoot(target_direction)


# accelerate towords direction
func _handel_movement(_direction, _acceleration):
    velocity.x = lerp(velocity.x, EntityData.Bee.Movement_speed * _direction.x, _acceleration)
    velocity.y = lerp(velocity.y, EntityData.Bee.Movement_speed * _direction.y, _acceleration)


func take_damage(_takken_damage, _entity_position = Vector2.ZERO):
    if can_take_damage == false:
#        Global.add_damage_popup_text("!", self, global_position)
        return
    
    life -= _takken_damage
    $HealthBar.emit_signal("value_changed", life)
    
    # pop text that show how much damage player deal
#    Global.add_damage_popup_text(_takken_damage, self, global_position)
    
    if life <= 0:
        self_destruction()
    else:
        fsm.travel("taking_damage")


func self_destruction():
    # effects
    Global.Camera.shake(2.5, .28)
    ScreenEffect.start_freez_screen(.09)
    ScreenEffect.start_abration(4, .2)
    ScreenEffect.start_flash_screen(.05, Color.white)
    
    EntityData.change_onscreen_bee_count(-1) # update count
    EntityData.change_onscreen_enemy_count(-1) # update count
    EntityData.change_current_kill_count(1)
    
    # spawn dead animation to tree and delete self instance
    var dead_animation_instance = Global.Dead_animation.instance()
    get_parent().add_child(dead_animation_instance)
    dead_animation_instance.global_position = global_position
    
    queue_free()


func set_can_take_damage(value: bool):
    can_take_damage = value


# controlling attack state cooldown
func _on_Timer_timeout() -> void:
    if not passiv_mode:
        if can_attack:
            fsm.travel("attacking")
    else:
        return


# Soft collision between another Bee
func _on_another_bee_detected(body: Node) -> void:
    if body.is_in_group("Bee"):
        sibling = body


func _on_sibling_exited_area(body: Node) -> void:
    if body.is_in_group("Bee"):
        if sibling == body:
            sibling = null
