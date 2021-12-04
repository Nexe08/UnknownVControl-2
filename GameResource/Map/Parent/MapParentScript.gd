extends Node2D
# Map parent Script

signal can_start_game

onready var enemy_count: int = 0
onready var kill_count: int = 0

onready var level_clear := false setget set_level_clear, get_level_clear
onready var portal = $Portal


func _ready() -> void:
    WaveModifire.current_map = self
    
    # Make Player enable
    if is_instance_valid(Global.Player):
        Global.Player.disable(false)
    
#    print(Global.Player.global_position)
    Global.Player.global_position = $PlayerSpawnPosition.global_position


# warning-ignore:unused_argument
func _process(delta: float) -> void:
    _update_HUD()


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


# called in parent character script
func set_enemy_count(value: int) -> void:
    enemy_count += value


# called in parent character script
func set_kill_count(value: int):
    kill_count += value
    pass

######################################
#                HUD
######################################


func _update_HUD():
    var _kill = $HUD/HBoxContainer/KillCount
    var _enemy = $HUD/HBoxContainer/EnemyCount
    
    _kill.text = String(kill_count)
    _enemy.text = String(enemy_count)
