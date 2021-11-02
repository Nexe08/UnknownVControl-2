extends KinematicBody2D
# Weapon Drop

"""
autostart timer
"""

var type
var choosen_weapon

var picked_up: bool = false setget set_picked_up

onready var lifetime_timer = $LifeTime
onready var lifetime_bar = $LifeTimeBar


func _ready() -> void:
    type = $WeaponsList.get_children()
    type.shuffle()
    choosen_weapon = type[0]
    choosen_weapon.visible = true


func _process(_delta: float) -> void:
    _handel_life_time_progress_bar()


# connect timer and progress bar
func _handel_life_time_progress_bar() -> void:
    lifetime_bar.max_value = lifetime_timer.wait_time
    lifetime_bar.value = lifetime_timer.time_left


func _on_LifeTime_timeout() -> void:
    queue_free()


# called by players weapon drop detector
func get_droped_weapon_type():
    if choosen_weapon:
        return choosen_weapon


# set get function
# called by players weapon drop detector
func set_picked_up(value: bool) -> void:
    picked_up = value
    
    if picked_up:
        queue_free()
