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
    var direction = parent.global_position.direction_to(target.global_position)
    
    if self_instance == null:
        parent.Velocity = lerp(parent.Velocity, speed * direction, 0.17)
    else:
        var dir = parent.global_position.direction_to(self_instance.global_position)
        parent.Velocity = lerp(parent.Velocity, speed * -dir, 0.17)


# called in animation player
func _set_can_attack(value: bool) -> void:
    can_attack = value


# called in animation player
func _set_can_move(value: bool) -> void:
    can_move = value


func _on_TargetDetector_body_entered(_body: Node) -> void:
    can_attack = true
    _set_can_move(false)


func _on_TargetDetector_body_exited(_body: Node) -> void:
    can_attack = false
    _set_can_move(true)


func _on_SelfInstanceDetector_area_entered(area: Area2D) -> void:
    if area.is_in_group("Bee"):
        self_instance = area


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
