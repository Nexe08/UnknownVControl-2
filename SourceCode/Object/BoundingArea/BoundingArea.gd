extends Area2D
# Bounding Area

export (NodePath) var respawn_position
onready var _position = get_node(respawn_position)


func _on_BoundingArea_body_entered(body: Node) -> void:
    if body.has_method("respawn"):
        body.respawn(_position.global_position)
