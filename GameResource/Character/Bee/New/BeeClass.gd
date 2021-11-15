extends Node2D
# Bee Class


# set get is used if in case we need to change speed when defficulty will incress
export var speed: float = 40 setget set_speed, get_speed

onready var parent:= get_parent()
onready var target = Global.Player

onready var can_move := false
onready var can_attack := false


func _ready() -> void:
    parent.Entity_child = self


# serve as _process/_physics_process
# called in parent
func _update(delta: float) -> void:
    $Label.text = String(can_move)
    if not can_move:
        return
    
    if is_instance_valid(target):
        _follow_target(delta)


func _follow_target(_delta: float) -> void:
#    var distance = parent.global_position.distance_to(target.global_position)
    var direction = parent.global_position.direction_to(target.global_position)
    
    parent.Velocity = lerp(parent.Velocity, speed * direction, 0.17)


# called in animation player
func _set_can_attack(value: bool) -> void:
    can_attack = value


# called in animation player
func _set_can_move(value: bool) -> void:
    can_move = value


func _on_TargetDetector_body_entered(_body: Node) -> void:
    can_attack = true


func _on_TargetDetector_body_exited(_body: Node) -> void:
    can_attack = false


# called by hit box component
func take_damage(takken_damage: float, _damage_direction:= Vector2.ZERO):
    var Life = parent.get_life()
    Life -= takken_damage
    parent.set_life(Life)


func set_speed(value: float) -> void:
    speed = value


func get_speed() -> float:
    return speed
