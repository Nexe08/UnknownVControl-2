extends Node2D
# ScreenshotSaturday


func _on_Timer_timeout() -> void:
    var node = Global.Bee.instance()
    add_child(node)
    node.passiv_mode = true
    node.global_position = $EnemyBound.global_position
