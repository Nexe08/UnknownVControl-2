extends Node2D
# ScreenshotSaturday


func _ready() -> void:
    Global.Player.global_position = $PlayerSpawnPosition.global_position


func _on_Timer_timeout() -> void:
    var node = Global.Bee.instance()
    add_child(node)
    node.passiv_mode = true
    node.global_position = $EnemyBound.global_position
