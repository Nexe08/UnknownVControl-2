extends Node2D
# Map parent Script

signal can_start_game

onready var level_clear := false setget set_level_clear, get_level_clear
onready var portal = $Portal


func _ready() -> void:
    WaveModifire.current_map = self
    
    # Make Player enable
    if is_instance_valid(Global.Player):
        Global.Player.disable(false)
    
#    print(Global.Player.global_position)
    Global.Player.global_position = $PlayerSpawnPosition.global_position



func _on_WeaponSelectionArea_selection_period_ended() -> void:
    # parent map will not spawn any task for player
    # inharited map scene will do it by itself
    emit_signal("can_start_game")


# wave modifire telles the map that all task is
# completed and no need to spawn enemy
# setget method
# called in wave modifire
func set_level_clear(value: bool) -> void:
    level_clear = value
    if level_clear:
        portal.get_activated()


func get_level_clear() -> bool:
    return level_clear
