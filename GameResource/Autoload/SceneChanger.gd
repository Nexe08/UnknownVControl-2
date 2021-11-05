extends Node2D
# SceneChanger

# warning-ignore:unused_signal
signal load_new_scene(new_scene, desire_parent)
# warning-ignore:unused_signal
signal load_new_map(new_map)

var next_scene
var next_scene_parent

var prev_scene

var new_map
var old_map


func _process(_delta: float) -> void: # debug
    $CanvasLayer/FPS.text = String(Engine.get_frames_per_second())


# just assigning old scene to variable
# its being removed in animation player by calling methode
func remove_scene(_scene):
    if is_instance_valid(_scene):
        prev_scene = _scene


# just assigning old map to variable
# its being removed in animation player by calling methode
func remove_map(_map):
    if is_instance_valid(_map):
        old_map = _map


# called in animation player
func _excute_scene_transition():
    if is_instance_valid(next_scene_parent): # is inside tree
        if next_scene != null: # is defined
            var node = next_scene.instance()
            next_scene_parent.add_child(node)
    
        if prev_scene != null:
            prev_scene.queue_free()


# called in animation player
func _excute_map_transition():
    var map_container = Global.MapContainer
    
    if is_instance_valid(map_container):
        if new_map != null:
            var map_instance = new_map.instance()
            map_container.add_child(map_instance)
        
        if old_map != null:
            old_map.queue_free()


func _on_scene_transition_started(new_scene, desire_parent) -> void:
    next_scene = new_scene
    next_scene_parent = desire_parent
    $CanvasLayer/ColorRect/AnimationPlayer.play("scene_transition")


func _on_SceneChanger_load_new_map(_new_map) -> void:
    new_map = _new_map
    $CanvasLayer/ColorRect/AnimationPlayer.play("map_transition")
