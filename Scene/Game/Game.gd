extends Node2D
# Game

#this script change map randomly every time player clear the wave
# for know there is only one wave

var wave_map = preload("res://Scene/WaveType/WaveType_1.tscn")

func _ready() -> void:
    randomize()
# warning-ignore:return_value_discarded
    WaveModifire.connect("change_wave", self, "_on_wave_changed")
    add_wave_map()
    
    Global.Game = self


func add_wave_map():
    var node = wave_map.instance()
    add_child(node)


func remove_prev_map():
    var prev_map = get_children()[0]
    if is_instance_valid(prev_map):
        prev_map.destroy()


func _on_wave_changed():
    remove_prev_map()
    add_wave_map()
