extends Node2D
# ScreenshotSaturday


func _ready() -> void:
    Global.Player.global_position = $PlayerSpawnPosition.global_position


func take_damage(_takken_damage, _entity_position = Vector2.ZERO):
    Global.add_damage_popup_text(_takken_damage, $Dummy, $Dummy.global_position)


func _on_Timer_timeout() -> void:
    var node = Global.Bee.instance()
    add_child(node)
    node.passiv_mode = true
    node.global_position = $EnemyBound.global_position
