extends Area2D
# Portal


export (NodePath) var root_scene
export (PackedScene) var next_map

export (bool) var exit_poral = false

onready var parent = get_node(root_scene)


func _on_Portal_body_entered(_body: Node) -> void:
    if not exit_poral:
        if next_map != null:
            SceneChanger.emit_signal("load_new_map", next_map)
            SceneChanger.remove_map(parent)
    else:
        print("Trying to exit Game.")
        # exit game
        pass


func _on_Portal_body_exited(_body: Node) -> void:
    # nothing to do for now
    pass
