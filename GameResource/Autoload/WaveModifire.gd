extends Node
# WaveModifire

# called by .....
signal can_change_wave

onready var current_map = null # currently active map

onready var current_wave: int = 1
onready var difficulty_threshold:= 0.2
onready var spawner_can_respawn:= true # tell the spawner that respawn other spawner if true


func _ready() -> void:
    EntityData.connect("kill_count_updated", self, "_on_EntityData_kill_count_updated")


# it will check all task or condition to alter next wave
func _check_wave_change_possibility():
    if EntityData.current_kill_count >= 10:
        if is_instance_valid(current_map):
            current_map.set_level_clear(true)
        
        emit_signal("can_change_wave")
        _update_difficulty()


func _update_difficulty():
    # Difficulty = InitialDifficulty + Level * DifficultyGradient
    EntityData.Bee.Life = abs(EntityData.Bee.Life + current_wave * difficulty_threshold)


# called by signal
# emmited in entityData script
func _on_EntityData_kill_count_updated(_count):
    _check_wave_change_possibility()
