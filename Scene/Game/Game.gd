extends Node2D
# Game

# This Script Do
#1 Load and delete maps
#2 Resets Entity data for new wave


onready var map_container = $MapContainer


func _ready() -> void:
    Global.Game = self
    WaveModifire.connect("can_change_wave", self, "_change_map")


# called by signal
# emmited in WaveModifire script
func _change_map():
    $TransitionAnimation.play("in")


# called in animation player
# animation out
func _add_new_map():
    var map_instance = Global.map_1.instance()
    map_container.add_child(map_instance)


# called in animation player
# animation in
func _remove_prev_map():
    # delete all child in map container
    for maps in map_container.get_children():
        maps.queue_free()
    
    EntityData.reset() # reset data for next wave


# emmited in wave change screen on next button pressed (space)
func _on_NextWaveButton_pressed() -> void:
    $TransitionAnimation.play("out")


############################# DEBUG ###########################################
func _process(_delta: float) -> void:
    _debug()

func _debug():
    $HUD/DEBUG/VBoxContainer/label.text = "Kill Count: " + String(EntityData.current_kill_count)
############################# DEBUG ###########################################
