extends Node2D
# Game

# This Script Do
#1 Load and delete maps
#2 Resets Entity data for new wave


onready var map_container = $MapContainer


func _ready() -> void:
    Global.Game = self
#    WaveModifire.connect("can_change_wave", self, "_change_map")


# called by map changing portal script
func change_map():
    var next_map = load("res://Scene/WaveMap/Map_1.tscn")
    
    SceneChanger.emit_signal("start_transition", next_map, $MapContainer)
    
    SceneChanger.remove_scene(WaveModifire.current_map)
    
    if is_instance_valid(Global.Player):
        Global.Player.disable(true)
    
    EntityData.reset() # reset data for next wave

