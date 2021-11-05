extends Node2D
# Weapon Selection Area Script

signal selection_period_ended

export (bool) var active = true

onready var timer = $SelectionTime
onready var bar = $LifeTimeBar


func _ready() -> void:
    if not active:
        visible = false
        set_process(false)
        set_process_internal(false)
        return
    
    bar.max_value = timer.wait_time
    bar.value = timer.time_left


func _process(_delta: float) -> void:
    bar.value = timer.time_left


# by signal
func _on_SelectionTime_is_out() -> void:
    disable(true)
    emit_signal("selection_period_ended")


func _on_1_weapon_was_choosen() -> void:
    disable(true)
    emit_signal("selection_period_ended")


func _on_2_weapon_was_choosen() -> void:
    disable(true)
    emit_signal("selection_period_ended")


func _on_3_weapon_was_choosen() -> void:
    disable(true)
    emit_signal("selection_period_ended")


# check (03/nov/2021)'s TODO for more 
# warning-ignore:unused_argument
func disable(value: bool) -> void:
    queue_free()
#    visible = !value
#    set_physics_process(!value)
#    set_physics_process_internal(!value)
#    set_physics_process(!value)
#    set_physics_process_internal(!value)
