extends KinematicBody2D
# Character parent Script

export var Life: float setget set_life, get_life


func set_life(value: float) -> void:
    Life = value

func get_life() -> float:
    return Life
