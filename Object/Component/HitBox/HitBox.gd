extends KinematicBody2D
# HitBox
# detects projectile or any damage taking object
# detects bounding area and then call parents respawn methode if parent have

export (NodePath) var root_node = ".."
onready var parent = get_node(root_node)



func take_damage(_damage, _entity_position:= Vector2.ZERO):
    if parent.has_method("take_damage"):
        parent.take_damage(_damage, _entity_position)


func respawn(_respawn_position=Vector2.ZERO):
    if parent.has_method("respawn"):
        parent.respawn(_respawn_position)
