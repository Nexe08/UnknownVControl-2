extends KinematicBody2D
# Character parent Script

export var Life: float setget set_life, get_life

onready var Velocity := Vector2.ZERO

var Entity_child

const UP = Vector2.UP


func _physics_process(delta: float) -> void:
    if Entity_child:
        if Entity_child.has_method("_update"):
            Entity_child._update(delta)
    
    Velocity = move_and_slide(Velocity, UP)


func set_life(value: float) -> void:
    Life = value

func get_life() -> float:
    return Life