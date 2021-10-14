extends Node
# WaveModifire

# called by main to change map
signal can_change_wave


func _ready() -> void:
    EntityData.connect("kill_count_updated", self, "_on_EntityData_kill_count_updated")


# it will check all task or condition to alter next wave
func _check_wave_change_possibility():
    if EntityData.current_kill_count >= 5000:
        emit_signal("can_change_wave")


# called by signal
# emmited in entityData script
func _on_EntityData_kill_count_updated(_count):
    _check_wave_change_possibility()
