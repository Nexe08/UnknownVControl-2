extends Node2D
# Enemy Spawn Manager

# this script ment to spawn enemy's in map scene
# all enemy need to be implemented

export (bool) var Spawn_Bee = false
export (bool) var Spawn_Grub = false

onready var parent = get_parent()
onready var Bee_scene_path = preload("res://Character/Bee/Bee.tscn")
onready var Grub_scene_path = preload("res://Character/Grub/Grub.tscn")


func _ready() -> void:
    parent.connect("can_start_game", self, "_set_can_spawn")


func _set_can_spawn(value: bool) -> void:
    if value == true:
        if Spawn_Bee:
            $BeeSpawningTimeout.start()
        
        if Spawn_Grub:
            $GrubSpawningTimeout.start()
    else:
        var timers = get_children()
        for timer in timers:
            if timer.is_class("Timer"):
                timer.stop()


func _on_BeeSpawningTimeout_timeout() -> void:
    if parent.get_level_clear():
        return
    
    EntityData.spawn_bee(parent)


func _on_GrubSpawningTimeout_timeout() -> void:
    if parent.get_level_clear():
        return
    
    EntityData.spawn_grub(parent)
