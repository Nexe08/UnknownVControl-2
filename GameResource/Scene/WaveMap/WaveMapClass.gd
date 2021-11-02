extends Node2D
class_name MapClass
# Parent Map Class


onready var level_clear := false setget set_level_clear
onready var next_map


func _ready() -> void:
    WaveModifire.current_map = self
    
    # Make Player enable
    if is_instance_valid(Global.Player):
        Global.Player.disable(false)
    
    Global.Player.global_position = $PlayerSpawnPosition.global_position


func _on_timer_out_spawn_bee() -> void:
    if level_clear:
        return
    
    EntityData.spawn_bee(self)


func _on_timer_out_spawn_droply() -> void:
    if level_clear:
        return
    
    EntityData.spawn_big_droply(self)


func _on_GrubSpawningTimer_timeout() -> void:
    if level_clear:
        return
    
    EntityData.spawn_grub(self)


# setget method
# called in wave modifire
func set_level_clear(value: bool):
    level_clear = value
    if level_clear:
        $MapChangingPortal.get_activated()
