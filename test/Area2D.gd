extends Area2D



func _on_Area2D_body_entered(body: Node) -> void:
    if body.has_method("flow"):
        body.flow(10)
        print("detected")
