extends Node2D
# SceneChanger
# warning-ignore:unused_signal
signal start_transition(new_scene, desire_parent)

var next_scene
var next_scene_parent

var prev_scene


func _process(_delta: float) -> void: # debug
    $CanvasLayer/FPS.text = String(Engine.get_frames_per_second())


func remove_scene(_scene):
    if is_instance_valid(_scene):
        prev_scene = _scene


# called in animation player
func _excute_transition():
    if is_instance_valid(next_scene_parent): # is inside tree
        if next_scene != null: # is defined
            var node = next_scene.instance()
            next_scene_parent.add_child(node)
    
        if prev_scene != null:
            prev_scene.queue_free()


func _on_scene_transition_started(new_scene, desire_parent) -> void:
    next_scene = new_scene
    next_scene_parent = desire_parent
    $CanvasLayer/ColorRect/AnimationPlayer.play("transition")
