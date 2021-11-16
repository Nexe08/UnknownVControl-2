extends Node2D
# Bee Class


# set get is used if in case we need to change speed when defficulty will incress
export var speed: float = 40 setget set_speed, get_speed

var instance_position

onready var can_move := false
onready var can_attack := false
onready var self_instance

onready var parent:= get_parent()
onready var target = Global.Player
onready var anim = $AnimationTree.get("parameters/playback")


func _ready() -> void:
    parent.Entity_child = self


# serve as _process/_physics_process
# called in parent
func _update(delta: float) -> void:
    if not can_move:
        parent.Velocity = Vector2.ZERO
        return
    
    if is_instance_valid(target):
        _follow_target(delta)


func _follow_target(_delta: float) -> void:
    var target_direction = parent.global_position.direction_to(target.global_position)
    var distance_from_target = parent.global_position.distance_to(target.global_position)
    
    if self_instance == null: # self instance isn't in range
        
        if distance_from_target < 32: # KEEP DISTANCE FROM PLAYER
            parent.Velocity = lerp(parent.Velocity, speed * -target_direction, 0.17)
            can_attack = false
        
        elif distance_from_target > 32 and distance_from_target < 64: # STOP MOVING
            parent.Velocity = lerp(parent.Velocity, Vector2.ZERO, 0.17)
            anim.travel("attack")
            can_attack = true
        
        else: # FOLLOW PLAYER
            parent.Velocity = lerp(parent.Velocity, speed * target_direction, 0.17)
            can_attack = false
    
    else: # KEEP DISTANCE FROM SELF INSTANCE
        var dir = parent.global_position.direction_to(self_instance.global_position)
        parent.Velocity = lerp(parent.Velocity, speed * -dir, 0.17)


# called in animation player
func _attack():
    var target_direction = parent.global_position.direction_to(target.global_position)
    
    var bullet_instance = Global.HostileBulletPath.instance()
    
    bullet_instance.global_position = parent.global_position
    bullet_instance.shoot(target_direction)
    parent.parent.add_child(bullet_instance)


# called in animation player
func _set_can_attack(value: bool) -> void:
    can_attack = value


# called in animation player
func _set_can_move(value: bool) -> void:
    can_move = value


# Self Instance Detection
func _on_SelfInstanceDetector_area_entered(area: Area2D) -> void:
    if area.is_in_group("Bee"):
        self_instance = area


# Self Instance Undetection
func _on_SelfInstanceDetector_area_exited(area: Area2D) -> void:
    if area.is_in_group("Bee"):
        self_instance = null


# called by hit box component
func take_damage(takken_damage: float, _damage_direction:= Vector2.ZERO):
    var Life = parent.get_life()
    Life -= takken_damage
    parent.set_life(Life)
    
    if parent.get_life() <= 0:
        anim.travel("death")
    else:
        anim.travel("damaged")


func set_speed(value: float) -> void:
    speed = value


func get_speed() -> float:
    return speed
