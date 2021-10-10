extends KinematicBody2D
# HitBox

export (NodePath) var root_node = ".."
onready var parent = get_node(root_node)


func take_damage(_damage, _entity_position):
    if parent.has_method("take_damage"):
        parent.take_damage(_damage, _entity_position)
