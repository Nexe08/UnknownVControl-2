extends Node2D
# Map parent Script

# instrucut $EnemySpawnManager that when to spawn and when not
signal can_start_game(value) # connected in enemy spawn manager

export (int) var required_kill_count = 30
export (int) var max_enemy_count = 50 # in each lap
export (int) var max_lap_count = 1

onready var lap_count : int = 0
onready var enemy_count : int = 0
onready var kill_count : int = 0

onready var level_clear := false setget set_level_clear, get_level_clear
onready var portal = $Portal


func _ready() -> void:
    WaveModifire.current_map = self
    
    # Make Player enable
    if is_instance_valid(Global.Player):
        Global.Player.disable(false)
    
    Global.Player.global_position = $PlayerSpawnPosition.global_position


# warning-ignore:unused_argument
func _process(delta: float) -> void:
    _update_HUD()


func _check_for_next_lap() -> void:
    if lap_count == max_lap_count:
        emit_signal("can_start_game", false)
    else:
        # check for enemy count
        # 0: start next lap
        # ! 0: clear map
        pass


func _on_WeaponSelectionArea_selection_period_ended() -> void:
    emit_signal("can_start_game", true)


# for now task are managed in wave modifire
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
    
    if kill_count > max_enemy_count:
        _check_for_next_lap()
        # stop spawning enemy
        
        # lap > 1 and enemy count is zero
        # increment in lap
        # spawn more enemy
        pass


######################################
#                HUD
######################################


func _update_HUD():
    var _kill = $CanvasLayer/HUD/HBoxContainer/KillCount
    var _enemy = $CanvasLayer/HUD/HBoxContainer/EnemyCount
    
    _kill.text = String(kill_count)
    _enemy.text = String(enemy_count)
